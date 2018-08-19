# frozen_string_literal: true

class Playlists::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_playlist
  before_action :set_comment, only: %i[destroy]

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
    unless current_user.owns?(@playlist)
      respond_to do |format|
        format.js   { render :delete_not_allowed }
        format.html { redirect_to playlists_url, error: "User can delete only own comments" }
        format.json { head :no_content }
      end && return
    end
    @comment.destroy
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

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
