# frozen_string_literal: true

class Playlists::ImportsController < ApplicationController
  before_action :authenticate_user!

  # POST /playlists/import/
  # POST /playlists/import/
  def create
    @playlist = Playlist.import_from_spotify(current_user, params[:spotify_id])
    if @playlist.valid?
      render :success
    else
      render :error
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end
