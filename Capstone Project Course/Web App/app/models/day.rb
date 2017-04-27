class Day < ApplicationRecord
    belongs_to :event, optional: true
    
end
