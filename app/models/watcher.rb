class Watcher < ActiveRecord::Base
  attr_accessible :id, :user_id, :username, :repository, :branch, :status

  belongs_to :user

  def check
    require "base64"

    user = User.find_by_id(self.user_id)
    github = Github.new :oauth_token => user.token
    
    begin
      gemfile_lock = github.repos.contents.get self.username, self.repository, 'Gemfile.lock', "ref" => self.branch
      gemfile_lock = gemfile_lock.to_hash

      gemfile_lock_content = gemfile_lock["content"]
      gemfile_lock_content = Base64.decode64(gemfile_lock_content)

      # regex each file for each line
      # check if it is the current gem
        # if it isn't - add to a list
        # if it is - don't add to a list
      # if list is greater then 1 - send pull request to user/repository with the list of gems out of date

      # github.issues.create watcher[:username], watcher[:repository], "title" => "UPDATE YOUR GEMFILES IMMEDIATELY", "body" => "You need to update your gemfiles immediately.", "assignee" => watcher[:username]
      # self.update_attributes :status => 'error'
      self.update_attributes :status => 'success'
    rescue
      # generally could not find Gemfile.lock in the repository
      self.update_attributes :status => 'not_found'
    end
  end

  def self.check_all
    watchers = Watcher.all
    watchers.each do |watcher|
      if watcher.status != 'error'
        watcher.check
      end
    end
  end
end
