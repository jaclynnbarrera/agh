require 'geocoder'
require 'httparty'

class LocationsController < ApplicationController
    file = File.read('public/locations.json')
    @@data_hash = JSON.parse(file)
    @@test_location = @@data_hash[0]
    @@matches = []

    def index
        if params[:lat]
            # calls to get matches function with query params
            get_matches(params["lat"], params["lng"], params["radius"])
        else
            render html: "please enter valid longitude, latitude and radius"
        end
    end

    #using test_location coordinates for testing purposes
    def get_matches(lat,lng,radius)

    end


end
