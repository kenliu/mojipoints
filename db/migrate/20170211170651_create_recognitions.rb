class CreateRecognitions < ActiveRecord::Migration[5.0]
  def change
    create_table :recognitions do |t|
      t.string :teamid
      t.string :subject
      t.string :text
      t.string :ts # the timestamp of the original recognition post
      t.string :slack_user_id # the slack user id of the person being recognized
      t.timestamps
    end
  end
end
