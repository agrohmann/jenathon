class User < ApplicationRecord
  geocoded_by :address
  validates_format_of :logo_url, :with => URI::regexp(%w(http https)), :allow_blank => true
  after_validation :geocode
end
