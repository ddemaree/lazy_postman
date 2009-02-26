$:.unshift File.dirname(__FILE__) # For use/testing when no gem is installed

require 'rubygems'
require 'activesupport'
require 'activeresource'
require 'actionmailer'

require 'logger'
#RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)

require 'lazy_postman/lazy_postman'
require 'lazy_postman/email'
require 'lazy_postman/message'

if File.exists?(config_path = "/etc/lazypost/config.rb")
  require config_path
end

if File.exists?(config_path = "/etc/lazypost/config.yml")
  LazyPostman.load_sites_from_file(config_path)
end