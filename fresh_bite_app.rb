require 'sinatra'
require 'active_record'
require 'mysql2'
require 'dotenv/load' # Optional for .env file
require 'sinatra/namespace'
require 'sinatra/activerecord'
require 'sinatra/cross_origin'
require 'logger'  # For custom logger

# Setup custom logger to log to a file
log_file = File.open('logs/freshbite_backend.log', 'a')
log_file.sync = true  # Ensures logs are written in real-time
logger = Logger.new(log_file)
logger.level = Logger::DEBUG

# Database connection setup
ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  port: '3306',
  host: 'localhost',
  username: 'root',
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

  # # Set the logger for Sinatra
  # configure do
  #   set :logger, logger
  # end

  # Include all helper modules
  helpers JwtToken

  # Default route for the main page
  get '/' do
    settings.logger.info "Serving index.html"
    send_file File.join(settings.public_folder, 'index.html')
  end

  configure do
    enable :cross_origin
    set :origins, 'http://localhost:8080' # Adjust for your frontend's origin
    set :allow_credentials, true
    set :session_secret, 'freshbite17012025'
    enable :sessions # Enable session handling globally

    # Log the configuration settings
    settings.logger.info "Sinatra Configuration: Cross-Origin enabled with origins: #{settings.origins}"
  end

  # API namespace and routes
  namespace '/api' do
    get '/' do
      settings.logger.info "Accessed /api endpoint"
      'Hello world! Welcome to RetailerAppStg API. This is V1 Application.'
    end

    namespace '/authentication' do
      register Sinatra::RetailerApp::Routing::Authentication
    end

    namespace '/portal' do
      register Sinatra::RetailerApp::Routing::Portal
    end
  end

  # Error handling
  error 500 do
    settings.logger.error "Internal Server Error: #{env['sinatra.error'].message}"
    'Internal Server Error, please check logs for details.'
  end
end
