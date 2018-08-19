# frozen_string_literal: true

class UserAllowedPlaylist < ApplicationRecord
  belongs_to :user
  belongs_to :playlist

  validate :not_allow_owner

  validates :user, uniqueness: { scope: :playlist }

  private

  def not_allow_owner
    return unless user_id != playlist.user_id
    errors.add(:user_id, "User already own the playlist and cannot be allowed")
  end
end
