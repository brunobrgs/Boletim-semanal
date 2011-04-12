# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.10' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  #config.time_zone = 'UTC'
  config.active_record.timestamped_migrations = false #Deixa o migrate gerar numeros sequenciais
  #Encoding.default_external="UTF-8"
  config.i18n.default_locale = "pt-BR"
	config.gem "mysql"
  
end

require 'tlsmail'
Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_content_type = "text/html"
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.raise_delivery_errors = true

