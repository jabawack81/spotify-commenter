# frozen_string_literal: true

class CreateUserAllowedPlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :user_allowed_playlists do |t|
      t.references :user, foreign_key: true
      t.references :playlist, foreign_key: true

      t.timestamps
    end
  end
end
