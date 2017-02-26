class AddDbConstraints < ActiveRecord::Migration[5.0]
  def change
    # recognitions table
    change_column_null :recognitions, :subject, false
    change_column_null :recognitions, :ts, false
    change_column_null :recognitions, :channel, false
    add_foreign_key :recognitions, :slack_users
    add_index :recognitions, :slack_user_id
    add_index :recognitions, :subject
    add_index :recognitions, :text

    # slack_teams table
    change_column_null :slack_teams, :teamid, false
    change_column_null :slack_teams, :oauth_access_token, false
    change_column_null :slack_teams, :bot_userid, false
    change_column_null :slack_teams, :bot_oauth_access_token, false

    # slack_users table
    change_column_null :slack_users, :slack_userid, false

    # votes table
    change_column_null :votes, :recognition_id, false
    change_column_null :votes, :slack_user_id, false
    change_column_null :votes, :first_vote, false
    change_column_default :votes, :first_vote, from: nil, to: true
    add_foreign_key :votes, :recognitions
    add_index :votes, :recognition_id
  end
end
