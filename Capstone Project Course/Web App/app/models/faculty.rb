class Faculty < ApplicationRecord
    belongs_to :event, optional: true
end
