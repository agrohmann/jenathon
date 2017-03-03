module Api::V1
  class BaseController < ApplicationController

    @@current_api_number = 1
	  @@current_api_version = "v" + @@current_api_number.to_s

	  def self.current_api_version
	    @@current_api_version
	  end

	  def self.current_api_number
	    @@current_api_number
	  end

  end
end