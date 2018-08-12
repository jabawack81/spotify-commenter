# frozen_string_literal: true

class PlaylistsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  delegate :url_helpers,      to: "Rails.application.routes"

  def initialize(view, user)
    @user = user
    @view = view
  end

  def as_json(_options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: spotify_playlists["total"],
      iTotalDisplayRecords: spotify_playlists.count,
      aaData: data
    }
  end

  private

  def data
    spotify_playlists["items"].map do |playlist|
      {
        name:  playlist.name,
        action: action_link(playlist.id)
      }
    end
  end

  def database_playlist
    @database_playlist ||= @user.playlists.where(spotify_id: spotify_playlists["items"].map(&:id)).to_a
  end

  def spotify_playlists
    @spotify_playlists ||= @user.spotify_playlists(per_page, page)
  end

  def page
    params[:iDisplayStart].to_i
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def action_link(id)
    imported = database_playlist.select { |playlist| playlist.spotify_id == id }.first
    if imported
      show = link_to  "Show",
                      url_helpers.playlist_path(imported)
      delete = link_to  "Remove",
                        url_helpers.playlist_path(imported),
                        method: :delete,
                        data: {
                          remote: true,
                          confirm: "Are you sure you want to delete this?"
                        }
      "#{show} | #{delete}"
    else
      link_to "Import",
              url_helpers.import_path(spotify_id: id),
              method: :post,
              data: {
                remote: true
              }
    end
  end
end
