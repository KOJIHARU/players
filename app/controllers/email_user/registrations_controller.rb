class EmailUser::RegistrationsController < ApplicationController
  def create
    @user = EmailUser.new(sign_up_params)
    @user.status = :inactive
    if @user.save
      origin = "#{request.protocol}#{request.host_with_port}"
      UserMailer.registration(@user.email, @user.registration_url(origin))
                .deliver_later
      head 201
    else
      render_error @user
    end
  end

  def regist
    @user = EmailUser.find(params[:registration_id].to_i)
    if @user.registered_by(params[:token])
      host = Rails.env.production? ? '' : 'http://localhost:3000'
      redirect_to "#{host}/#/?registed=ok"
    else
      render_error @user, 401
    end
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation)
  end
end
