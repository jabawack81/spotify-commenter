# frozen_string_literal: true

class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :spotify_artist
      t.string :spotify_album_name
      t.json :spotify_album_images
      t.string :spotify_id
      t.string :spotify_href
      t.string :spotify_name
      t.string :spotify_preview_url

      t.timestamps
    end
  end
end
