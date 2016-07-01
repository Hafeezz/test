require 'rubygems'
require 'selenium-webdriver'
require 'rspec'
require 'rspec/autorun'
require 'rspec/expectations'
require 'json'
require 'rest-client'

describe "Get Hyatt's ID and publish its address" do
  $api_key = "SJwXP1gBpNDS2vKn3qpMMEpn7S3rtzH1d5L5HYcu"
  it "get Hyatt Austin's station ID" do
    location = "Austin"
    network = "ChargePoint Network"
    res = RestClient.get "https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?ev_network=#{network}&location=#{location}&limit=10&api_key=#{$api_key}"
    response = JSON.parse(res.body)
    all_stations =  response['fuel_stations']
    Hyatt_station = all_stations.select{|a| a['station_name']=="HYATT AUSTIN"}
    Hyatt_id = Hyatt_station.map {|i| i['id']}.first
  end

  it "get Hyatt Austin's address with station ID" do
    given_address = "208 Barton Springs Rd, Austin, TX, 78704"
    res = RestClient.get "https://developer.nrel.gov/api/alt-fuel-stations/v1/#{Hyatt_id}.json?api_key=#{$api_key}"
    response = JSON.parse(res.body)
    street =  response['alt_fuel_station']['street_address']
    city =  response['alt_fuel_station']['city']
    state = response['alt_fuel_station']['state']
    zip = response['alt_fuel_station']['zip']
    gotten_address =  street +", "+city+", "+state+", "+ zip
    if gotten_address.eql? given_address
      puts "--address obtained matches given--"
    else
      puts "--address are not matching--"
    end
  end
end

