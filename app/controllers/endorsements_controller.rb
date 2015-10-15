class EndorsementsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @review.endorsments.create
    redirect_to restaurant_path
  end
end
