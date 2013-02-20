class Watcher < ActiveRecord::Base
  attr_accessible :id, :user_id, :username, :repository, :branch

  belongs_to :user

  def self.watching
    require "base64"

    watchers = Watcher.all
    watchers.each do |watcher|
      user = User.find_by_username(watcher[:username])
      github = Github.new :oauth_token => user.token
      
      begin
        gemfile_lock = github.repos.contents.get watcher[:username], watcher[:repository], 'Gemfile.lock', "ref" => watcher[:branch]

        gemfile_lock = gemfile_lock.to_hash

        gemfile_lock_content = gemfile_lock["content"]
        gemfile_lock_content = Base64.decode64(gemfile_lock_content)

        #regex each file for each line
        #check if it is the current gem
          #if it isn't - add to a list
          #if it is - don't add to a list
        #if list is greater then 1 - send pull request to user/repository with the list of gems out of date

        github.issues.create watcher[:username], watcher[:repository], "title" => "UPDATE YOUR GEMFILES IMMEDIATELY", "body" => "You need to update your gemfiles immediately.", "assignee" => watcher[:username]
      end
    end
  end
end
