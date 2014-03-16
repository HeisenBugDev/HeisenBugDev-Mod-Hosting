require 'base64'
require 'json'
require 'net/http'

manifest = JSON.parse(IO.read('upload_data/manifest.json'))

manifest['artifacts'].each do |artifact|
  content = File.binread("upload_data/#{artifact['file']}")
  artifact['file_data'] = Base64.encode64(content)
end

req = Net::HTTP::Post.new('/builds', 'Content-Type' => 'application/json')
req.body = manifest.to_json

response = Net::HTTP.new('localhost', '3000').start do |http|
  http.request(req)
end

puts response.body
puts response
