class CreateSlackTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_teams do |t|
      t.string :teamid
      t.string :oauth_access_token
      t.string :bot_userid
      t.string :bot_oauth_access_token
      t.timestamps
    end
  end
end
