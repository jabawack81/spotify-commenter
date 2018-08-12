# frozen_string_literal: true

class Playlists::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_playlist

  def create
    @comment = @playlist.comments.new(
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
  def set_playlist
    @playlist = Playlist.find(params[:playlist_id])
  end
end
