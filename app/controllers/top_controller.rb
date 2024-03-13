class TopController < ApplicationController
  def index
    @random_boards = Board.order("RAND()").limit(3)
  end
end
