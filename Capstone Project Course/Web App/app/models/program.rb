class Program < ApplicationRecord

  has_many :sound_sequences
  has_many :sounds, through: :sound_sequences

  has_many :user_programs
  has_many :users, through: :user_programs

  def create_sounds(sound_array, user_id)
    cont = 1
    sound_array.each { |sound|
      sd = Sound.new(name:'Nombre',description:'Descripción', program: true, added_by: user_id, sound_file: sound)
      sd.save
      self.sound_sequences.create(program_id:self.id, sound_id:sd.id, order: cont)
      cont+=1
    }
  end

  def delete_sounds
    self.sounds.each { |sound| sound.destroy }
  end

  def check_content(sound_array)
    sound_array.each { |sound|
      if sound.content_type =~ %r(sound)
      else
        false
      end
    }
    true
  end

  def self.generate_display_web()
  end

  def self.generate_display_mobil()
    Program.all
  end
end
