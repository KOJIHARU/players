class Session
  include ActiveModel::Model

  def initialize(params)
    @params = params
  end

  def save
    if authenticate
      true
    else
      errors[:base] << I18n.t('errors.messages.sessions.invalid_parameters')
      false
    end
  end

  def token
    return nil unless authenticate
    @token ||= user.add_access_token
  end

  private

  def authenticate
    user && user.active? && user.authenticate(@params[:password])
  end

  def user
    @user ||= find_user
  end

  def find_user
    EmailUser.find_by(email: @params[:email])
  end
end
