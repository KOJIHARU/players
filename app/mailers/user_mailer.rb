class UserMailer < ApplicationMailer
  # TODO: Locationが英語の場合、英語のメールが送信されるようにする

  # アカウント登録のご案内
  def registration(email, registration_url)
    @email = email
    @registration_url = registration_url
    mail to: email
  end

  # アカウント登録完了のお知らせ TODO: 必要不要を検討する
  def finished_registration(email)
    @email = email
    mail to: email
  end
end
