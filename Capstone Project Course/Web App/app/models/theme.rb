class Theme < ApplicationRecord
  has_and_belongs_to_many :videos
  has_and_belongs_to_many :images
  has_and_belongs_to_many :sounds

end
