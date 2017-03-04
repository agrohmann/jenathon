class StaticPagesController < ApplicationController
  def home
    @users = User.all
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.description
      unless user.logo_url.blank?
        marker.picture({
          "url" => user.logo_url,
          "width" => 32,
          "height" => 32
        })
      end
    end

    # check for search params
    if params.key?(:max_date_time)
      # set search condition
	    search_conditions.push("targeted_at > ?")
      search_conditions.push("targeted_at < ?")

		  # get events for user only, + search conditions
      @events = Event.where(search_conditions.join(" and "), Time.zone.now, Time.zone.parse(params[:max_date_time]))
    else
      @events = Event.all
    end

    @hash2 = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
      marker.infowindow event.description

      case event.category
      when "party"
        icon_url = "http://139.59.135.199/icons/party.png"
      else
        icon_url = "http://139.59.135.199/icons/standard.png"
      end

      marker.picture({
          "url" => icon_url,
          "width" => 32,
          "height" => 32
        })
    end
  end
end
