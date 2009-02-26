require File.dirname(__FILE__) + '/test_helper'

class EmailTest < ActiveSupport::TestCase
  
  # def test_new_email_resource_should_be_saved
  #   assert true
  # end
  
  def setup
    ActiveResource::HttpMock.respond_to do |mock|
      # mock.get "/tools/1/users/2.xml", {}, user(:eric)
      # # some ActiveResource requests append these empty parameters, in any order
      # # and you can't seem to use regexps with HttpMock right now
      # mock.get "/tools/1/users/2.xml?include=&conditions=", {}, user(:eric)
      # mock.get "/tools/1/users/2.xml?conditions=&include=", {}, user(:eric)
      # mock.get "/tools/1/users/3.xml", {}, user(:matt)
      # mock.get "/tools/1/users/4.xml", {}, user(:paper)
      # mock.get "/tools/1/users/0.xml", {}, nil, 404
      # mock.get "/tools/1/users/.xml", {}, nil, 404
      
      mock.post "/emails.xml", {}, nil, 201, "Location" => "/emails/1.xml"
    end
  end
  
  context "new Email resource" do
    setup { @email = Email.new(:to => "david@practical.cc", :from => "david@gmail.com")}
  
    should "be saved" do
      assert_nothing_raised do
        @email.save
      end
    end
  end
  

  
end