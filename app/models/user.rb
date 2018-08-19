# frozen_string_literal: true

class User < ApplicationRecord
  has_many :playlists
  validates_uniqueness_of :email
  validates_uniqueness_of :uid

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.display_name || "" if auth["info"]
      user.avatar = auth.info.images.first.url
        user.email = auth.info.email
    end
  end

  def owns?(element)
    element.user_id == id
  end

  def spotify_playlists(limit, offset)
    RSpotify::User.find(uid).playlists(limit: limit, offset: offset)
  end
end
