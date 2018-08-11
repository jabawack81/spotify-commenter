# frozen_string_literal: true

class Playlists::ImportsController < ApplicationController
  before_action :authenticate_user!

  # POST /playlists/import/
  # POST /playlists/import/
  def create
    @playlist = Playlist.import_from_spotify(current_user, params[:spotify_id])
    p @playlist.errors
    respond_to do |format|
      if @playlist.valid?
        format.js { render :success }
        format.json { render json: :playlist_imported, status: :ok }
      else
        format.js { render :error }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end
