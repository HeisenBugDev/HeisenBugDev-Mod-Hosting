require 'net/https'
require 'json'

class ProjectsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }

  REPO      = 'HeisenBugDev/HeisenBugDev-content'
  BRANCH    = 'master'
  FILE      = 'projects.json'
  GITHUB    = URI("https://raw.github.com/")

  def request_file
    http              = Net::HTTP.new(GITHUB.host, GITHUB.port)
    http.use_ssl      = true
    http.verify_mode  = OpenSSL::SSL::VERIFY_NONE
    request           = Net::HTTP::Get.new(@urn)
    response          = http.request(request)
  end

  def file_string
    request_file.body.to_s
  end

  def data_from_file
    JSON.parse(file_string)
  end

  def perform(urn = nil)
    @urn = "/#{REPO}/#{BRANCH}/#{get_file_name}"
    @urn = urn unless urn.blank?
    data = data_from_file

    data["projects"].each do |key|
      name = key['name']
      if Project.exists?(:name => name)
        @project = Project.find_by_name(name)
      else
        @project = Project.new(:name => name)
      end
      @project.update(key)
    end
  end

private
  def get_file_name
    return 'projects_test_env.json' if Rails.env.test?
    FILE
  end
end