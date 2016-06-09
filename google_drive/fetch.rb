require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'

client_secrets = Google::APIClient::ClientSecrets.load
auth_client = client_secrets.to_authorization
auth_client.update!(
  :scope => "https://www.googleapis.com/auth/drive",
  :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob'
)

auth_uri = auth_client.authorization_uri.to_s
puts "the url is:"
puts auth_uri

puts 'Paste the code from the auth response page:'
auth_client.code = gets
auth_client.fetch_access_token!


auth_client.fetch_access_token!
access_token = auth_client.access_token
refresh_token = auth_client.refresh_token

puts "your access_token is:\n#{access_token}"
puts "----"

puts "your refresh_token is:\n#{refresh_token}"
puts "----"
puts "done!"

