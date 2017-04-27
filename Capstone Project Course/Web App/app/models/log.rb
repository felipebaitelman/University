class Log < ApplicationRecord
  belongs_to :media, polymorphic: true
  belongs_to :user
end
