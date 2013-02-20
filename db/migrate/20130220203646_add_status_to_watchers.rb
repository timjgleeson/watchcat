class AddStatusToWatchers < ActiveRecord::Migration
  def change
    add_column :watchers, :status, :string
  end
end
