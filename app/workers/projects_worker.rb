require 'net/https'
require 'json'

class ProjectsWorker
  include Sidekiq::Worker

  REPO    = 'HeisenBugDev/HeisenBugDev-content'
  BRANCH  = 'master'
  FILE    = 'projects.json'
  GITHUB  = URI("https://raw.github.com/")
  URN     = "/#{REPO}/#{BRANCH}/#{FILE}"


  def request_file
    http              = Net::HTTP.new(GITHUB.host, GITHUB.port)
    http.use_ssl      = true
    http.verify_mode  = OpenSSL::SSL::VERIFY_NONE
    request           = Net::HTTP::Get.new(URN)
    response          = http.request(request)
  end

  def file_string
    request_file.body.to_s
  end

  def data_from_file
    JSON.parse(file_string)
  end

  def perform
    data = data_from_file

    data["projects"].each do |key|
      puts Project.exists?(:name => key[:name.to_s])
    end
  end
end