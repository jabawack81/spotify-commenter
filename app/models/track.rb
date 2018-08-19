# frozen_string_literal: true

class Track < ApplicationRecord
  has_many :playlist_tracks
  has_many :playlists, through: :playlist_tracks

  def self.import_multiple_from_spotify(spotify_tracks)
    spotify_tracks.map do |spotify_track|
      find_or_create_by(spotify_id: spotify_track.id) do |track|
        track.spotify_artist = spotify_track.artists.map(&:name).join(", ")
        track.spotify_album_name = spotify_track.album.name
        track.spotify_album_images = spotify_track.album.images
        track.spotify_id = spotify_track.id
        track.spotify_href = spotify_track.href
        track.spotify_name = spotify_track.name
        track.spotify_preview_url = spotify_track.preview_url
      end
    end
  end

  def medium_image_url
    spotify_album_images.select { |image| image["height"] <= 350 && image["height"] >= 250 }.first["url"]
  end
end


