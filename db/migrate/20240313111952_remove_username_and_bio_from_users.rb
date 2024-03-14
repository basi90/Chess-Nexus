class RemoveUsernameAndBioFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :username
    remove_column :users, :bio
  end
end
