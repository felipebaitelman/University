module Loggable
  extend ActiveSupport::Concern

  module ClassMethods
  end

  def create_log_entry(media_type, user_id, date)
    @log = Log.new(media_id:self.id, media_type:media_type, user_id: user_id, date:date)
    @log.save
  end

  def add_labels(labels)
    if labels.present?
      labels.each do | theme |
        self.themes << Theme.find_by(name: theme)
      end
    end
  end

  def add_topics(labels)
    if labels.present?
      labels.each do | topic |
        self.topics << Topic.find_by(name: topic)
      end
    end
  end

end
