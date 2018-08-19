# frozen_string_literal: true

class Playlists::AllowedUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_playlist
  before_action :set_allowed_user, only: %i[destroy]

  def create
    @allowed_user = @playlist.user_allowed_playlists.new(user_allowed_playlists_params)
    if @allowed_user.save
      render :success
    else
      render :error
    end
  end

  def destroy
    unless current_user.owns?(@playlist)
      respond_to do |format|
        format.js   { render :delete_not_allowed }
        format.html { redirect_to playlists_url, error: "User can delete only owned playlists" }
        format.json { head :no_content }
      end && return
    end
    @allowed_user.destroy
    respond_to do |format|
      format.js
      format.html
      format.json
    end
  end

  private

  def user_allowed_playlists_params
    params.require(:user_allowed_playlist).permit([:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_playlist
    @playlist = Playlist.find(params[:playlist_id])
  end

  def set_allowed_user
    @allowed_user = Comment.find(params[:id])
  end
end
