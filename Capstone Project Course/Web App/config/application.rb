require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.assets.paths << "#{Rails.root}/app/assets/videos"
    config.assets.enabled = true
    config.i18n.default_locale = :es
    config.autoload_paths += %W(#{config.root}/lib)
    config.time_zone = 'America/Santiago'
    
    config.active_job.queue_adapter = :sidekiq #setting sidekiq :)  
  end
end
