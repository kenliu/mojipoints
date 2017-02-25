# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.

# filter text from slack message events
Rails.application.config.filter_parameters += ['event.text'] if Rails.env.production?
