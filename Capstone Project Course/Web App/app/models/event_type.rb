class EventType < ApplicationRecord
    belongs_to :event,  optional: true
end
