class UserMailer < ActionMailer::Base
  default from: "aziz@azizlight.me"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def reset_password_email(user)
    @user = user
    @url = "http://localhost.3000/password_resets/#{user.reset_password_token}/edit"

    mail(:to => user.email)
  end
end
