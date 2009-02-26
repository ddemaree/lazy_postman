#require File.join(File.dirname(__FILE__), "..", "lazy_postman.rb")
require File.join(File.dirname(__FILE__), *%w[.. lib lazy_postman])

#require 'test/unit'
#require 'redgreen'
require 'shoulda'
require 'test_help'
require 'active_resource/http_mock'
#require 'factory_girl'

class ActiveSupport::TestCase
end