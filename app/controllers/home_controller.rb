# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:account]

  def index; end

  def invite
    redirect_to root_url, flash: { alert: "you alredy have an account" } if current_user
    @invite = params[:invite_code]
    @invited_user = User.find_by_invitation_code(@invite)
  end

  def account
    respond_to do |format|
      format.html
      format.json { render json: PlaylistsDatatable.new(view_context, current_user) }
    end
  end
end
