#Configuration File
require 'rubygems'
require 'sinatra'
require File.expand_path '../fresh_bite_app.rb', __FILE__

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  port: ENV['DB_PORT'],
  host: ENV['DB_HOST'],
  username: ENV['DB_USERNAME'],
  password: ENV['DB_PASSWORD'],
  database: ENV['DB_DATABASE']
)

run FreshBiteApp