# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( creative/manifest.js creative/manifest.css )
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf|png|jpg)\z/
Rails.application.config.assets.precompile += %w( *.js )
Rails.application.config.assets.precompile += %w( *.png, *.jpg )
Rails.application.config.assets.precompile += [ 'foundry/*' ]
Rails.application.config.assets.precompile += %w( plans.css )
Rails.application.config.assets.precompile += %w( sly.css )
Rails.application.config.assets.precompile += %w( alphabetical_paginate.js )
