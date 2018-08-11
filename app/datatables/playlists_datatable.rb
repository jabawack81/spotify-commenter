# frozen_string_literal: true

class PlaylistsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view, user)
    @user = user
    @view = view
  end

  def as_json(_options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: playlists["total"],
      iTotalDisplayRecords: playlists.count,
      aaData: data
    }
  end

  private

  def data
    playlists["items"].map do |playlist|
      {
        name:  playlist.name,
        action: false
      }
    end
  end

  def playlists
    @playlists ||= fetch_playlists
  end

  def fetch_playlists
    @user.spotify_playlists(per_page, page)
  end

  def page
    params[:iDisplayStart].to_i
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end
end
