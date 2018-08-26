# frozen_string_literal: true

class User < ApplicationRecord

  scope :by_email_or_invitation_code, -> (email, invitation_code) {
    where(
      email: email
    ).
    or(
      User.where(
        invitation_code: invitation_code
        )
      )
  }

  has_many :playlists, dependent: :destroy
  has_many :user_allowed_playlists, dependent: :destroy
  has_many :allowed_playlists, through: :user_allowed_playlists, source: :playlist
  has_many :invitee, class_name: "User"

  belongs_to :inviter, class_name: "User", optional: true, foreign_key: :user_id

  validates_uniqueness_of :invitation_code, if: :invitation_code
  validates_uniqueness_of :email
  validates_uniqueness_of :uid, if: :uid?

  validates_presence_of :email

  before_validation :generate_invitation_code, if: :invited
  after_create :send_invitation_email, if: :invited

  attr_accessor :invited

  def self.create_with_omniauth(auth, params)
    in_db = by_email_or_invitation_code(auth.info.email, params["invite"]).first
    if in_db
      in_db.update_attributes(
        email: auth.info.email,
        provider: auth.provider,
        uid: auth.uid,
        name: auth.info.display_name,
        avatar: auth.info.images.first&.url,
        invitation_code: nil
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

  def display_name
    name || email
  end

  private

  def send_invitation_email
    NotificationMailer.invite(self).deliver_now
  end

  def uid?
    !uid.nil?
  end

  def generate_invitation_code(length=6)
    self.invitation_code = loop do
      # To avoid ambiguity, 0, 1, 8, B, I, O, U, V are not present.
      chars = "ACDEFGHJKLMNPQRSTWXYZ2345679"
      random_token = ""
      length.times { random_token += chars[rand(chars.size)] }
      break random_token unless User.exists?(invitation_code: random_token)
    end

  end

end
