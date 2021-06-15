class AlertMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.alert_mailer.alert.subject
  #
  def alert
    # FOR REAL USE (also with letter opener)
    @alert = Alert.find(params[:id])
    @errors_array = params[:error]

    # FOR PREVIEW USE
    # @alert = Alert.first
    # @errors_array = [{ error: "content", db: "open", new: "closed" }]

    mail(to: @alert.user.email, subject: 'New alert - TravelColour') do |format|
      format.mjml
    end
  end

  def subscribe
    # Real
    @country = Country.find(params[:id])
    @user = User.find(params[:id])

    # Fake
    # @country = Country.first
    # @user = User.first

    mail(to: @user.email, subject: 'You set up an alert - TravelColour') do |format|
      format.mjml
    end
  end
end
