class SearchesController < ApplicationController
  def index
    @initial_position = { lat: 35.6585805, lng: 139.7454329 }
  end
end
