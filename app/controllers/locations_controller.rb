require 'geocoder'
require 'httparty'

class LocationsController < ApplicationController
    file = File.read('public/locations.json')
    @@data_hash = JSON.parse(file)
    @@test_location = @@data_hash[0]
    @@matches = []

    def index
        binding.pry
    end

end
