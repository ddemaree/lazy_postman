class LazyPostman
  cattr_accessor :logger, :options, :endpoints
  @@options = {}
  @@endpoints = {}
  
  class Endpoint
    attr_reader :site, :user, :password
    
    def initialize(site, user=nil, password=nil)
      @site, @user, @password = site, user, password
    end
  end
  
  def self.load_sites_from_file(path)
    YAML.load_file(path).each do |domain, settings|
      @@endpoints[domain] = Endpoint.new(settings["site"], settings["user"], settings["password"])
    end
  end
  
  def self.receive(raw)
    msg   = Message.receive(raw)
    
    domain_delivered_to = msg.parsed_recipient_from_delivered_to.domain
    endpoint = self.endpoints[domain_delivered_to]
    
    if endpoint.nil?
      return nil
    end
    
    Email.site = endpoint.site
    Email.user = endpoint.user
    Email.password = endpoint.password
    
    email = Email.new({
      :to      => {
        :address => msg.parsed_recipient.address,
        :domain  => msg.parsed_recipient.domain,
        :user    => msg.parsed_recipient.local
      },
      :from    => {
        :address => msg.parsed_sender.address,
        :domain  => msg.parsed_sender.domain,
        :user    => msg.parsed_sender.local
      },
      :body    => msg.body.strip,
      :subject => msg.subject.strip,
      :raw     => msg.raw
    })
    
    email.save
  rescue ActiveResource::ResourceNotFound
    puts "Could not save email — resource not found"
  end
  
end