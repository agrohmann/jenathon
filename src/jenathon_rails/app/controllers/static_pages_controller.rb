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
  end
end
