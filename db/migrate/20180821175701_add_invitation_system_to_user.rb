class AddInvitationSystemToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :user, foreign_key: true
    add_column :users, :invite_email, :string
    add_column :users, :invitation_code, :string, uniq: true
    add_index :users, :invitation_code
  end
end
