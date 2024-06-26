# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    params = request.env["omniauth.params"]
    auth = request.env["omniauth.auth"]
    user = User.where(
      provider: auth["provider"],
      uid: auth["uid"].to_s
    ).first || User.create_with_omniauth(auth, params)
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication error: #{params[:message].humanize}"
  end
end
