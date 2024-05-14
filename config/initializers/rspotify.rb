RSpotify.pagination_info = true
RSpotify.authenticate(
  Rails.application.credentials.spotify[:client_id],
  Rails.application.credentials.spotify[:client_secret]
)
