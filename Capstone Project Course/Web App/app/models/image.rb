class Image < ApplicationRecord
  include Loggable

  has_attached_file :image_file, styles: { thumb: ["300x150#", :png] }

  has_and_belongs_to_many :themes
  has_many :image_sequences
  has_many :infographics, through: :image_sequences

  validates_attachment_content_type :image_file,
                                    :content_type => /^image\/(png|gif|jpeg)/,
                                    :message => 'only (png/gif/jpeg) images'

end

