#Configuration File
require 'rubygems'
require 'sinatra'
require File.expand_path '../fresh_bite_app.rb', __FILE__


run FreshBiteApp

set :port, 3000
