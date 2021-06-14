class ReviewsController < ApplicationController

  def create
    @country = Country.find(params[:country_id])
    @review = Review.new(review_params)
    @review.country = @country
    @review.user = current_user

    if @review.save
      redirect_to country_path(@country)
    else
      render "countries/show"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to user_path(@review.user)
  end

  private

  def review_params
    params.require(:review).permit(:stars, :content)
  end
end
