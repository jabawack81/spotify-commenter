# frozen_string_literal: true

class User < ApplicationRecord
  has_many :playlists

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.display_name || "" if auth["info"]
      user.avatar = auth.info.images.first.url
    end
  end

  def spotify_playlists(limit, offset)
    RSpotify::User.find(uid).playlists(limit: limit, offset: offset)
  end
end
