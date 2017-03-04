class AddUserFlagToRecognition < ActiveRecord::Migration[5.0]
  def change
    add_column :recognitions, :user_subject, :boolean, nil: false, default: true
  end
end
