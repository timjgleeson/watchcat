class User < ActiveRecord::Base
  attr_accessible :avatar_url, :github_id, :name, :username, :token

  has_many :watchers

  after_create :setup_watchers

  private
  def setup_watchers
    for i in 1..3
      Watcher.create(:user_id => self.id)
    end
  end
end
