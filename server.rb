require 'sinatra'
require_relative 'model/model'
require 'json'

set :lock, true

get '/data' do
    input_capacity = params['input_capacity']
    input_load_factor = params['input_load_factor']

    s = Model.new
    s.input_capacity = input_capacity.to_f if input_capacity
    s.input_load_factor = input_load_factor.to_f if input_load_factor

    result = {
        input_capacity: s.input_capacity,
        input_load_factor: s.input_load_factor,
        output_energy: s.output_energy,
        output_revenue: s.output_revenue,
        output_years: s.output_years.flatten,
        output_capacity_by_year: s.output_capacity_by_year,
    }
    
    result.to_json
end
