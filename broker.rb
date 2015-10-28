require 'sinatra'
require 'json'

class ServiceBrokerApp < Sinatra::Base
  use Rack::Auth::Basic do
    true
  end

  get "/v2/catalog" do
    content_type :json

    {services:
     [{id: "deb122d3-343a-4529-ab9c-73fffe312632",
       name: "slow-service",
       description: "Provides a really slow service",
       bindable: true,
       tags: ["slow"],
       metadata: {},
       plans:
       [{id: "dcc87d02-b12b-4988-adb2-1802bb8d8ed0",
         name: "slow",
         description: "Really slow",
         metadata: {}
        }]
      }]
    }.to_json
  end

  put "/v2/service_instances/:id" do |id|
    content_type :json
    sleep wait_time
    status 201
    {}.to_json
  end

  put '/v2/service_instances/:instance_id/service_bindings/:id' do |_, _|
    content_type :json
    sleep wait_time
    status 201
    {credentials: {username: 'slow', password: 'slow'}}.to_json
  end

  delete '/v2/service_instances/:instance_id/service_bindings/:id' do |_, _|
    content_type :json
    sleep wait_time
    status 200
    {}.to_json
  end

  delete '/v2/service_instances/:instance_id' do |_|
    content_type :json
    sleep wait_time
    status 200
    {}.to_json
  end

  private

  def wait_time
    ENV['WAIT_SECONDS'].to_i || 59
  end
end
