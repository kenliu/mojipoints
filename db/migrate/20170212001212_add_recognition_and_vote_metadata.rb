class AddRecognitionAndVoteMetadata < ActiveRecord::Migration[5.0]
  def change
    add_column :recognitions, :channel, :string

    add_column :votes, :emoji, :string
    add_column :votes, :first_vote, :boolean
  end
end
