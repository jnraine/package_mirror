require 'ostruct'
require 'open-uri'
# require 'pathname'

class Mirror < OpenStruct
  PACKAGE_DIR = Pathname.new("/Users/jnraine/projects/jungle/instance/munkiserver/packages")
  MASTER_HOST = "http://localhost:3000"
  
  def self.get(id)
    response_body = open(url(id)).read
    json_body = JSON.parse(response_body)
    if json_body["package"].present?
      package_attr = json_body["package"]
      self.new(package_attr)
    else
      nil # maybe we should throw something
    end
  end
  
  def self.url(id)
    "#{MASTER_HOST}/pkgs/#{id}.json"
  end
  
  def initialize(package_attr)
    super
    self.created_at = Time.parse(package_attr.delete("created_at"))
    self.updated_at = Time.parse(package_attr.delete("updated_at"))
    # package_attr.each do |name, value|
    #   self.send("#{name}=", value)
    # end
  end
  
  def download_filename    
    "#{name}-#{version}#{extension}"
  end
  
  def extension
    if installer_item_location.match(/(\.\w+)\z/)
      $1
    else
      ""
    end
  end
end
