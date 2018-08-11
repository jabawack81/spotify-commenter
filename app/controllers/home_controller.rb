# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def account
    respond_to do |format|
      format.html
      format.json { render json: PlaylistsDatatable.new(view_context, current_user) }
    end
  end
end
