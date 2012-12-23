lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bundler/setup'
require 'tentd'
require 'tentd-admin/app'
require 'tentd-admin/server'
require 'tentd-admin/oauth_redirect'
require 'rack/ssl-enforcer'
require 'logger'

Sequel.connect(ENV['DATABASE_URL'], :logger => Logger.new(STDOUT))

use Rack::SslEnforcer, hsts: true if ENV['RACK_ENV'] == 'production'

map '/' do
  use SetEntity
  run TentD::Server.new
end

map '/oauth' do
  run TentD::OAuthRedirect
end

map '/admin' do
  run TentD::Admin
end
