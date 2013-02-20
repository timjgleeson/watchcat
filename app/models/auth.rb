class Auth < ActiveRecord::Base
  def self.repositories(token)
    github = Github.new :oauth_token => token
    repositories = github.repos.list
    list = []
    
    repositories.each do |repository|
      r = repository.to_hash
      name = r["name"]
      fullname = r["full_name"]
      
      collection = Hash["name" => name, "fullname" => fullname]

      list << collection
    end

    list
  end

  def self.branches(token, username, repository_name)
    github = Github.new :oauth_token => token
    branches = github.repos.branches username, repository_name
    list = []

    branches.each do |branch| 
      b = branch.to_hash

      name = b["name"]

      list << Hash["name" => name]
    end

    list
  end

  def self.repositories_and_branches(token, username)
    github = Github.new :oauth_token => token
    repositories = github.repos.list
    list = []
    
    repositories.each do |repository|
      r = repository.to_hash

      name = r["name"]
      fullname = r["full_name"]
      branches = Auth.branches(token, username, name)

      collection = Hash["name" => name, "fullname" => fullname, "branches" => branches]

      list << collection
    end

    list
  end
end