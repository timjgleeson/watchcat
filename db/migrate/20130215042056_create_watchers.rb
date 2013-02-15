class CreateWatchers < ActiveRecord::Migration
  def change
    create_table :watchers do |t|
      t.string :repo_id
      t.string :full_repo
      t.string :branch

      t.timestamps
    end
  end
end
