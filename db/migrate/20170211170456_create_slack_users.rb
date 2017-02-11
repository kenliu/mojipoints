class CreateSlackUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_users do |t|
      t.string :teamid
      t.string :slack_userid
      t.string :slack_name
      t.timestamps
    end
  end
end
