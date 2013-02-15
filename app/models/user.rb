class User < ActiveRecord::Base
  attr_accessible :avatar_url, :github_id, :name, :username, :token
end
