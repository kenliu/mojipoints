class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.string :teamid
      t.integer :recognition_id
      t.integer :slack_user_id
      t.boolean :upvote
      t.timestamps
    end
  end
end
