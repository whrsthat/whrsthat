class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.boolean :attending

      t.timestamps null: false
    end
  end
end
