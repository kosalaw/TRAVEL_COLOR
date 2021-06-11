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

    mail(to: @alert.user.email, subject: 'New alert - TravelColour')
  end
end
