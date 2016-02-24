class UserMailer < ApplicationMailer
  # TODO: Locationが英語の場合、英語のメールが送信されるようにする

  # アカウント登録のご案内
  def registration(email, registration_url)
    @email = email
    @registration_url = registration_url
    mail to: email
  end
end
