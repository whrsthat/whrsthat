class AddUserToInvitee < ActiveRecord::Migration
  def change
    add_reference :invitees, :user, index: true, foreign_key: true
  end
end
