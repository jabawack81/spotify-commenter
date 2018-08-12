# frozen_string_literal: true

class PlaylistTrack < ApplicationRecord
  belongs_to :playlist
  belongs_to :track

  has_many :comments, as: :commentable
end
