class ChangeVotePlusMinus < ActiveRecord::Migration[5.0]
  def change
    remove_column :votes, :upvote, :boolean
    add_column :votes, :point, :integer, null: false, default: 1
  end
end
