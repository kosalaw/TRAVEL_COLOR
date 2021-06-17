class AlertsController < ApplicationController
  # display in account page
  def index
    @alerts = current_user.alerts
  end

  # new alert button in on country show page
  def create
    if params[:alert].present?
      @alert = Alert.new(alert_params)
    else 
      @alert = Alert.new()
    end

    @country = Country.find(params[:country_id]) if @alert.country.blank?
    @alert.country = @country if @alert.country.blank?
    @alert.user = current_user

    if @alert.save
      AlertMailer.with(country_id: @alert.country.id, user_id: @alert.user.id).subscribe.deliver_later
      if params.dig(:alert, :country_id).present?
        redirect_to user_path(:id)
      else
       redirect_to country_path(@alert.country)
      end
    else
      render "countries/show"
    end
  end

  def destroy
    @alert = Alert.find(params[:id])
    @alert.destroy
    redirect_back(fallback_location: country_path(@alert.country))
    # redirect_to country_path(@alert.country)
  end

  private

  def alert_params
    params.require(:alert).permit(:country_id)
  end
end
