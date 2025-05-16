require 'sinatra'
require 'sinatra/cookies'
require 'json'
require_relative '../models/testing'

enable :sessions
set :session_secret, 'freshbite17012025'  # Ensure secret key for sessions is set


module Sinatra
  module RetailerApp
    module Routing
      module Portal
        def self.registered(app)

          app.before do
            if request.media_type == 'application/json'
              request.body.rewind
              @request_payload = JSON.parse(request.body.read, symbolize_names: true) rescue {}
            else
              @request_payload = params
            end
          end

          app.post '/authenticate' do
            content_type :json
            puts "Received Authenticate Request:"
            puts @request_payload.inspect

            employee_code = @request_payload[:employee_code]
            pin = @request_payload[:pin]

            if employee_code.nil? || pin.nil?
              status 400
              return { messagecode: 400, message: "Employee Code and PIN are required" }.to_json
            end

            if employee_code == "EMP001" && pin == "12345"
              session[:logged_in] = true
              session[:employee_code] = employee_code
              puts "SESSION AFTER SETTING: #{session.inspect}"  # Log session to verify
              { messagecode: 200 }.to_json
            else
              status 401
              { messagecode: 401, message: "Credentials not Matched" }.to_json
            end
          end

          app.get '/dashboard' do
            puts "SESSION BEFORE CHECKING: #{session.inspect}"
            if session[:logged_in]
              content_type :html
              erb :portal_dashboard  # Ensure your dashboard page is rendered properly
            else
              halt 401, "Unauthorized"
            end
          end

          app.post '/upload_distribution' do
            begin
            # Log headers to check the content type
            puts "REQUEST HEADERS: #{request.env.select { |k, v| k.start_with? 'HTTP_' }.inspect}"
            if session[:logged_in]
              content_type :json
              { messagecode: 200, message: "Distribution uploaded successfully!" }.to_json
            else
              halt 401, { message: 'Unauthorized' }.to_json
            end
          rescue JSON::ParserError => e
            halt 400, { message: 'Invalid JSON format', error: e.message }.to_json
          end
        end







        end
      end
    end
  end
end
