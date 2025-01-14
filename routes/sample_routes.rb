require_relative '../models/testing'

module Sinatra
  module RetailerApp
    module Routing
      module SampleRoutes
        def self.registered(app)
          app.get '/sample' do
            content_type :json
            results = Testing.all_records
            results = [{"name":"munendra"}]
            results.to_json
          end
        end
      end
    end
  end
end
