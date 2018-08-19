# frozen_string_literal: true

class PlaylistsController < ApplicationController
  before_action :set_playlist, only: %i[show destroy]
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: ImportedPlaylistsForUserDatatable.new(view_context, current_user) }
    end
  end

  def show; end

  def destroy
    unless current_user.owns?(@playlist)
      respond_to do |format|
        format.js   { render :delete_not_allowed }
        format.html { redirect_to playlists_url, error: "User can delete only owned playlists" }
        format.json { head :no_content }
      end && return
    end
    @playlist.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to playlists_url, notice: "Playlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end
