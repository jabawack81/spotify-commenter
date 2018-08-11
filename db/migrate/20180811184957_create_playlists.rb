# frozen_string_literal: true

class CreatePlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :playlists do |t|
      t.references :user, foreign_key: true
      t.string :spotify_id
      t.string :spotify_description
      t.string :spotify_href
      t.string :spotify_name
      t.string :spotify_uri
      t.string :spotify_snapshot_id
      t.json :spotify_images

      t.timestamps
    end
  end
end
