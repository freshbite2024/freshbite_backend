require_relative '../models/testing'

module Sinatra
  module RetailerApp
    module Routing
      module SampleRoutes
        def self.registered(app)
          app.get '/sample' do
            content_type :json
            puts "COMMING IN SAMPLE API DATA"
            results = Testing.all_records
            # results = [{"name":"naga munendra", "mobile":"70751175111"}]
            results.to_json
          end
        end
      end
    end
  end
end
