# frozen_string_literal: true

class Playlists::Tracks::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_playlist_and_track

  def create
    @comment = @track.comments.new(
      body: params[:comment][:body],
      user: current_user
    )
    if @comment.save
      render :success
    else
      render :error
    end
  end

  def destroy
    @playlist.destroy
    respond_to do |format|
      format.js
      format.html
      format.json
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_playlist_and_track
    @playlist = Playlist.find(params[:playlist_id])
    @track = @playlist.playlist_tracks.find(params[:track_id])
  end
end
