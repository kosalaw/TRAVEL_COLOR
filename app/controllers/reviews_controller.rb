class ReviewsController < ApplicationController

  def create
    @country = Country.find(params[:country_id])
    @review = Review.new(review_params)
    @review.country = @country
    @review.user = current_user

    if @review.save?
      redirect_to country_path(@country, anchor: "review-#{review.id}")
    else
      render "countries/show" #file path
    end
  end


  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to country_path(@review.country)
  end

  private

  def review_params
    params.require(:review).permit(:stars, :content)
  end
end
