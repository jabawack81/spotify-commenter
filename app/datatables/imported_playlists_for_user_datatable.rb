# frozen_string_literal: true

class ImportedPlaylistsForUserDatatable
  delegate :params, :link_to, to: :@view
  delegate :url_helpers,      to: "Rails.application.routes"

  def initialize(view, user)
    @view = view
    @user = user
  end

  def as_json(_options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Playlist.allowed_or_owned_by_user(@user).count,
      iTotalDisplayRecords: playlists.count,
      aaData: data
    }
  end

  private

  def data
    playlists.map do |playlist|
      {
        name:  playlist.spotify_name,
        owner: playlist.user.name,
        action: action_link(playlist)
      }
    end
  end

  def playlists
    @playlists ||= fetch_playlists
  end

  def fetch_playlists
    playlists = Playlist.allowed_or_owned_by_user(@user).order("#{sort_column} #{sort_direction}")
    playlists = playlists.page(page).per_page(per_page)
    if params[:sSearch].present?
      playlists = playlists.where("LOWER(spotify_name) LIKE LOWER(:search)", search: "%#{params[:sSearch]}%")
    end
    playlists
  end

  def page
    params[:iDisplayStart].to_i / per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[spotify_name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def action_link(playlist)
    show = link_to  "Show",
                    url_helpers.playlist_path(playlist)
    delete = link_to  "Remove",
                      url_helpers.playlist_path(playlist),
                      method: :delete,
                      data: {
                        remote: true,
                        confirm: "Are you sure you want to delete this?"
                      }
    if playlist.user_id == @user.id
      "#{show} | #{delete}"
    else
      show
    end
  end
end
