# frozen_string_literal: true

require "rspotify/oauth"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :spotify,
    Rails.application.credentials.spotify[:client_id],
    Rails.application.credentials.spotify[:client_secret],
    scope: %w[
      playlist-read-private
      playlist-read-collaborative
      user-read-email
    ].join(" ")
  )
end
