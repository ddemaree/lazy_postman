class Email < ActiveResource::Base
  self.site = "http://localhost:3000"
  
  def initialize(params={})
    params.reverse_merge!({
      :to   => "",
      :from => ""
    })
    
    super(params)
  end
  
  def new_from_message(message)
    new({
      :body => message.body,
      :to   => message.recipient_from_to,
      :from => message.sender
    })
  end
  
protected

  def validate
    raise "BLAH"
    %w(to from).each do |header|
      errors.add(header, "can't be blank") if self.send(header).blank?
    end
  end

end