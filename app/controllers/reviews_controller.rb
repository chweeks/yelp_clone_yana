class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build_with_user review_params, current_user

    if @review.save
      redirect_to restaurants_path
    elsif @review.errors[:user]
        redirect_to restaurants_path, alert: 'You have already reviewed this restaurant'
      else
        render :new
    end
  end

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
