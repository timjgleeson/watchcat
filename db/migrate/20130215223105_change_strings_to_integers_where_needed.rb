class ChangeStringsToIntegersWhereNeeded < ActiveRecord::Migration
  def up
    change_column :users, :github_id, :integer
  end

  def down
    change_column :users, :github_id, :string
  end
end
