require 'net/https'

class ProjectsWorker
  include Sidekiq::Worker

  REPO    = 'HeisenBugDev/HeisenBugDev-content'
  BRANCH  = 'master'
  FILE    = 'projects.json'
  GITHUB  = URI("https://raw.github.com/")
  URN     = "/#{REPO}/#{BRANCH}/#{FILE}"

  def perform
  end

  def request_file
    http              = Net::HTTP.new(GITHUB.host, GITHUB.port)
    http.use_ssl      = true
    http.verify_mode  = OpenSSL::SSL::VERIFY_NONE
    request           = Net::HTTP::Get.new(URN)
    response          = http.request(request)
  end
end