# frozen_string_literal: true

class User < ApplicationRecord
  has_many :playlists, dependent: :destroy
  validates_uniqueness_of :email
  validates_uniqueness_of :uid

  def self.create_with_omniauth(auth)
    in_db = find_by_email(auth.info.email)
    if in_db
      in_db.update_attributes(
        provider: auth.provider,
        uid: auth.uid,
        name: auth.info.display_name,
        avatar: auth.info.images.first&.url
      )
      in_db
    else
      create! do |user|
        user.email = auth.info.email
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.display_name
        user.avatar = auth.info.images.first&.url
      end
    end
  end

  def owns?(element)
    element.user_id == id
  end

  def spotify_playlists(limit, offset)
    RSpotify::User.find(uid).playlists(limit: limit, offset: offset)
  end
end
