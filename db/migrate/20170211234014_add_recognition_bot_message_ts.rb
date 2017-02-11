class AddRecognitionBotMessageTs < ActiveRecord::Migration[5.0]
  def change
    add_column :recognitions, :bot_msg_ts, :string
  end
end
