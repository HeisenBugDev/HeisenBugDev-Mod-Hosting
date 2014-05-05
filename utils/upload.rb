require 'base64'
require 'json'
require 'net/http'
require 'dotenv'
Dotenv.load
manifest = JSON.parse(IO.read('upload_data/manifest.json'))

manifest['artifacts'].each do |artifact|
  content = File.binread("upload_data/#{artifact['file']}")
  artifact['file_data'] = Base64.encode64(content)
end

req = Net::HTTP::Post.new('/builds.json', 'Content-Type' => 'application/json')
req['X-User-Email'] = ENV['HBD_EMAIL']
req['X-User-Token'] = ENV['HBD_TOKEN']
req.body = manifest.to_json

response = Net::HTTP.new('localhost', '8080').start do |http|
  http.request(req)
end

puts response.body
puts response
