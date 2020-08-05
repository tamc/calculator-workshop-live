require 'sinatra'
require_relative 'model/model'
require 'json'

set :lock, true

get '/data' do
    capacity = params['input_capacity']

    s = Model.new
    s.capacity = capacity.to_f if capacity

    result = {
        input_capacity: s.capacity,
        output_energy: s.output,
    }
    
    result.to_json
end
