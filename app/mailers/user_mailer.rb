class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @greeting = "Hi"

    mail(to: "test@test.com", subject: 'New alert - TravelColour') do |format|
      format.mjml
    end
  end
end
