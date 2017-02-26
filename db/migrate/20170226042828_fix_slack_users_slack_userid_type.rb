class FixSlackUsersSlackUseridType < ActiveRecord::Migration[5.0]
  def change
    change_column :slack_users, :slack_userid, :string, null: false
  end
end
