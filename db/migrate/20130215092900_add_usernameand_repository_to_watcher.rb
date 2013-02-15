class AddUsernameandRepositoryToWatcher < ActiveRecord::Migration
  def change
    add_column :watchers, :username, :string
    add_column :watchers, :repository, :string
  end
end
