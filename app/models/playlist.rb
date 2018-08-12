# frozen_string_literal: true

class Playlist < ApplicationRecord
  belongs_to :user

  has_many :playlist_tracks
  has_many :tracks, through: :playlist_tracks

  validates_uniqueness_of :spotify_id, message: "Playlist already imported"
  validates_presence_of :spotify_id,
                        :spotify_href,
                        :spotify_name,
                        :spotify_images,
                        :spotify_snapshot_id,
                        :spotify_uri

  def self.import_from_spotify(user, spotify_playlist_id)
    spotify_playlist = RSpotify::Playlist.find(user.uid, spotify_playlist_id)
    local_tracks = Track.import_multiple_from_spotify(spotify_playlist.tracks)
    create(
      user:                user,
      spotify_id:          spotify_playlist.id,
      spotify_description: spotify_playlist.description,
      spotify_href:        spotify_playlist.href,
      spotify_name:        spotify_playlist.name,
      spotify_images:      spotify_playlist.images,
      spotify_snapshot_id: spotify_playlist.snapshot_id,
      spotify_uri:         spotify_playlist.uri,
      tracks:              local_tracks
    )
  end
end
