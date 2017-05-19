# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
# require 'spree/app_configuration_decorator'
Spree.config do |config|

  ### Removed S3 Cloud Object Storage

  # Don't use SSL in production
  config.allow_ssl_in_production = false
  
  # Enabling email      # disabled due to the 2.3 upgrade and extracted   spree_mail_settings gem


  if Rails.env.production?
    # config.mail_port = 465
    # other configs ..
  else
    # config.mail_port = 465
    # other configs ..
  end
end

Spree.user_class = "Spree::User"
