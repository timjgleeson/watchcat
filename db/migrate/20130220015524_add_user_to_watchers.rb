class AddUserToWatchers < ActiveRecord::Migration
  def change
    add_column :watchers, :user_id, :integer
  end
end
