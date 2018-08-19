# frozen_string_literal: true

class PlaylistsController < ApplicationController
  before_action :set_playlist, only: %i[show destroy]

  # GET /playlists/1
  # GET /playlists/1.json
  def show; end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    respond_to do |format|
      format.js   { render :delete_not_allowed }
      format.html { redirect_to playlists_url, error: "User can delete only owned playlists" }
      format.json { head :no_content }
    end && return if !current_user.owns?(@playlist)
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
