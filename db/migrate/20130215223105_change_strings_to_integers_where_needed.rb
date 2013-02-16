class ChangeStringsToIntegersWhereNeeded < ActiveRecord::Migration
  def up
    remove_column :users, :github_id
    add_column :users, :github_id, :integer
  end

  def down
    remove_column :users, :github_id
    add_column :users, :github_id, :string
  end
end
