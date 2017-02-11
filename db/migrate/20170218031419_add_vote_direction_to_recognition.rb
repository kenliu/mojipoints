class AddVoteDirectionToRecognition < ActiveRecord::Migration[5.0]
  def change
    add_column :recognitions, :vote_direction, :boolean, null: false, default: true
  end
end
