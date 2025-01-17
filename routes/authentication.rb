require_relative '../models/testing'

module Sinatra
  module RetailerApp
    module Routing
      module Authentication
        def self.registered(app)
          
          app.get '/request_otp' do
            content_type :json
            puts "COMMING IN REQUEST OTP"
            results = Testing.custom_query
            # results = [{"name":"naga munendra", "mobile":"70751175111"}]
            results << {"request":"from the request OTP"}
            results.to_json
          end

          app.get '/validate_otp' do
            content_type :json
            puts "COMMING IN REQUEST OTP"
            results = Testing.custom_query
            token = generate_token({ user: "munendra" })
            # results = [{"name":"naga munendra", "mobile":"70751175111"}]
            {"messagecode":200,"message":"Successfully validated", "token":token}.to_json
          end


        end
      end
    end
  end
end
