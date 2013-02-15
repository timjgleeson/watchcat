class RemoveFullRepoFromWatcher < ActiveRecord::Migration
  def up
    remove_column :watchers, :full_repo
  end

  def down
    add_column :watchers, :full_repo, :string
  end
end
