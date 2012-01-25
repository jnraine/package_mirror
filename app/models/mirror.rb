require 'ostruct'
require 'open-uri'
# require 'pathname'

class Mirror < OpenStruct
  
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
    "#{master_hostname}/pkgs/#{id}.json"
  end
  
  def self.settings
    PackageMirror::Application::SETTINGS
  end
  
  def self.master_hostname
    settings["master_hostname"]
  end
  
  def self.packages_dir
    settings["packages_dir"]
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
