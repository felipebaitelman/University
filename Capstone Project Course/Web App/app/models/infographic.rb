class Infographic < ApplicationRecord
  include Loggable

  has_many :logs, as: :media
  has_many :image_sequences
  has_many :images, through: :image_sequences

  has_and_belongs_to_many :topics
  has_many :logs, as: :media


  def create_images(image_array, user_id)
    cont = 1
    image_array.each { |image|
        im = Image.new(name:"Nombre", description: 'Descripición', added_by: user_id, image_file: image)
        im.save
        self.image_sequences.create(infographic_id:self.id, image_id:im.id, order: cont)
        cont+=1
    }
  end

  def delete_images
    self.images.each { |image| image.destroy }
  end

  def check_content(image_array)
    image_array.each { |image|
      if image.content_type =~ %r(image)
      else
        false
      end
    }
    true
  end

  def self.fetch_all_infos(hash)
    Infographic.joins(:topics).each do |info|
      info.topics.each do |topic|
        Topic.all.each do |aux|
          if aux.name==topic.name
            hash[aux.name] << info
          end
        end
      end
    end
    hash
  end

  def self.choose_random(hash,all_infos)
    Topic.all.each do |topic|
      hash[topic.name]=all_infos[topic.name][rand(all_infos[topic.name].count)]
    end
    hash
  end

  def self.add_images(image_hash, info_hash)
    Topic.all.each do |topic|
      info = info_hash[topic.name]
      if info != nil
        image_hash[topic.name] = Array.new(info.images.count)
        info.images.each do |image|
          image_hash[topic.name][ImageSequence.where(image_id:image.id, infographic_id: info.id).first.order-1] = image
        end
      end
    end
    image_hash
  end

  def self.add_images_mobil(image_hash, all_info_hash)
    Topic.all.each do |topic|
      image_hash[topic.name] = Array.new
      all_info_hash[topic.name].each do |infographic|
        images = Array.new(infographic.images.count)
        infographic.images.each do |image|
          images[ImageSequence.where(image_id:image.id, infographic_id: infographic.id).first.order] = image
        end
        images[0] = infographic.as_json
        image_hash[topic.name] << images
      end
    end
    image_hash
  end

  def self.generate_display_web()
    all_infos = Hash.new
    Topic.all.each do |aux|
      all_infos[aux.name] = Array.new
    end
    all_infos = Infographic.fetch_all_infos(all_infos)
    infos = Hash.new
    #choose random
    infos = Infographic.choose_random(infos,all_infos)
    #add image files
    hash = Hash.new
    return Infographic.add_images(hash, infos)
  end

  def self.generate_display_mobil(hash)
    all_infos = Hash.new
    Topic.all.each do |aux|
      all_infos[aux.name] = Array.new
    end
    all_infos = Infographic.fetch_all_infos(all_infos)
    Infographic.parse_hash_mobil(all_infos)
  end

  def self.parse_hash_mobil(hash)
    result = Array.new
    hash['Concéntrate'].each do |program|
      result << program
    end
    hash['Empodérate'].each do |program|
      result << program
    end
    hash['Desactívate'].each do |program|
      result << program
    end
    result
  end

  def image_file_file_name
    if self.topics.first.name == 'Empodérate'
      'S3.png '
    else if self.topics.first.name == 'Desactívate'
           'S2.png'
         else
           'S1.png'
         end
    end
  end

  def image_url
    if self.topics.first.name == 'Empodérate'
      'http://d1kthnqllbvoat.cloudfront.net/sequences/S3.png '
    else if self.topics.first.name == 'Desactívate'
           'http://d1kthnqllbvoat.cloudfront.net/sequences/S2.png'
         else
           'http://d1kthnqllbvoat.cloudfront.net/sequences/S1.png'
         end
    end
  end

end




