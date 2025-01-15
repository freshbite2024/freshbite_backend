require 'sinatra'
require 'active_record'
require 'mysql2'
require 'dotenv/load'  # Optional for .env file
require 'sinatra/namespace'
require 'sinatra/activerecord'

# ActiveRecord::Base.establish_connection(
#   adapter: 'mysql2',
#   port: '27005',
#   host: 'mysql-freshbite-munendra0412-3e77.c.aivencloud.com',
#   username: 'munendra',
#   password: 'AVNS_AtTD6atRjgWRyaDKs7q',
#   database: 'freshbite'
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
Dir["helpers/*.rb"].each { |helper| require_relative helper }

# Load routes dynamically
Dir["routes/*.rb"].each { |route| require_relative route }

class FreshBiteApp < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :public_folder, 'views'  # Serve static files from the views folder

  register Sinatra::Namespace
  register Sinatra::ActiveRecordExtension

  # Default route for the main page
  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
  end

  # API namespace and routes
  namespace '/api' do
    get '/' do
      'Hello world! Welcome to RetailerAppStg API. This is V1 Application.'
    end

    # Load additional routes under /api/index namespace
    namespace '/index' do
      register Sinatra::RetailerApp::Routing::SampleRoutes
    end
  end
end
