require 'sinatra'
require 'active_record'
require 'mysql2'
require 'dotenv/load' # Optional for .env file
require 'sinatra/namespace'
require 'sinatra/activerecord'
require 'sinatra/cross_origin'

# Establish database connection
# ActiveRecord::Base.establish_connection(
#   adapter: 'mysql2',
#   port: '3306',
#   host: 'host.docker.internal', # Connects to MySQL on the host machine
#   username: 'root',
#   password: 'root',
#   database: 'freshbite_mysql'
# )

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  port: '3306', # Standard MySQL port
  host: '35.200.224.30', # Reserved static IP
  username: 'munendra',
  password: 'Aarush210621@',
  database: 'freshbite_mysql'
)

# Load helpers dynamically
Dir["#{File.dirname(__FILE__)}/helpers/*.rb"].each { |helper| require_relative helper }

# Load routes dynamically
Dir["#{File.dirname(__FILE__)}/routes/*.rb"].each { |route| require_relative route }

class FreshBiteApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :public_folder, 'views' # Serve static files from the views folder

  register Sinatra::Namespace
  register Sinatra::ActiveRecordExtension
  register Sinatra::CrossOrigin

  # Include all helper modules
  helpers JwtToken

  # Default route for the main page
  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
  end

  configure do
    enable :cross_origin
    set :origins, 'http://localhost:8080' # Adjust for your frontend's origin
    set :allow_credentials, true
    set :session_secret, 'freshbite17012025'
    enable :sessions # Enable session handling globally
  end

  # API namespace and routes
  namespace '/api' do
    get '/' do
      'Hello world! Welcome to RetailerAppStg API. This is V1 Application.'
    end

    namespace '/authentication' do
      register Sinatra::RetailerApp::Routing::Authentication
    end

    namespace '/portal' do
      register Sinatra::RetailerApp::Routing::Portal
    end
  end
end
