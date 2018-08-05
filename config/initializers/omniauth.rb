# frozen_string_literal: true

require "rspotify/oauth"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :spotify,
    ENV["CLIENT_ID"],
    ENV["CLIENT_SECRET"],
    scope: %w[
      playlist-read-private
      playlist-read-collaborative
      user-read-email
    ].join(" ")
  )
end
