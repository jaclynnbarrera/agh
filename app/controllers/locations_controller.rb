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
            render json: @@matches
        else
            render html: "please enter valid longitude, latitude and radius"
        end
    end

    def get_matches(lat,lng,radius)
        @@data_hash.each do |location|
            #using test_location coordinates for testing purposes
            if Geocoder::Calculations.distance_between([@@test_location["lat"],@@test_location["lng"]], [location["lat"], location["lng"]]) <= radius.to_f
                @@matches.push(location)
                open_weather(location)
            end
        end
    end

    def open_weather(location)
        key = "ceb6657dfd5aab9f00e5b48bfde5c001"
        url = "https://api.openweathermap.org/data/2.5/weather?lat=#{location["lat"]}&lon=#{location["lng"]}&units=imperial&appid=#{key}"
        response = HTTParty.get(url)
        location["weather"] = response
    end

end
