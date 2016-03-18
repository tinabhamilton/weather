class HomeController < ApplicationController
  def index
  	@states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC)
  	@states.sort!

  	if params[:city] != nil
  		params[:city].gsub! " ", "_"
  		response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")

  	else
		response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/NC/Charlotte.json")
	end

  	@location = response['location']['city']
  	@temp_f = response['current_observation']['temp_f']
  	@temp_c = response['current_observation']['temp_c']
  	@weather_icon = response['current_observation']['icon_url']
  	@weather_word = response['current_observation']['weather']
  	@forecast_link = response['current_observation']['forecast_url']
  	@feels_like = response['current_observation']['feelslike_f']

  	if @weather_words == "Overcast" || @weather_words == "Cloudy" 
  		@url = "http://thumbs3.dreamstime.com/t/horses-cades-cove-great-smoky-mtns-nat-park-tn-10422726.jpg"
  		@url = "http://thumbs3.dreamstime.com/t/horses-cades-cove-great-smoky-mtns-nat-park-tn-10422726.jpg"
elsif @weather_words == "Rain" || @weather_words == "Thunderstorms"
  @url = "http://thumbs3.dreamstime.com/t/horses-cades-cove-great-smoky-mtns-nat-park-tn-10422726.jpg"
elsif @weather_words == "Snow" || @weather_words == "Sleet" || @weather_words == "Flurries"
  @url = "http://thumbs3.dreamstime.com/t/horses-cades-cove-great-smoky-mtns-nat-park-tn-10422726.jpg"
elsif @weather_words == "Fog" 
 	@url = "http://thumbs3.dreamstime.com/t/horses-cades-cove-great-smoky-mtns-nat-park-tn-10422726.jpg"
else 
  @url = "http://thumbs.dreamstime.com/x/spring-trees-fields-45193.jpg"
end
  end
end
