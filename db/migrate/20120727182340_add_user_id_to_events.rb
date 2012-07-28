class AddUserIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :user_id, :integer
    rename_column :events, :name, :description
  end
end
