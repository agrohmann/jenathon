class Event < ApplicationRecord
  geocoded_by :address
  after_validation :geocode

  # overwrite as_json method to add virtual attributes
  def as_json(options = { })
    # call super as_json method
    h = super(options)

    case category.downcase
    when "party"
      icon_url = "http://139.59.135.199/icons/party.png"
    when "tech"
      icon_url = "http://139.59.135.199/icons/tech.png"
    when "party"
      icon_url = "http://139.59.135.199/icons/social.png"
    else
      icon_url = "http://139.59.135.199/icons/standard.png"
    end

    h[:icon_url] = icon_url

    # return output
    h
  end
end
