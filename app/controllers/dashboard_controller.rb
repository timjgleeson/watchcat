class DashboardController < ApplicationController
  def index
    if cookies[:token]
      github = Github.new :oauth_token => cookies[:token]

      @user = User.find_by_github_id(github.users.get.id)
      @repositories = []

      repositories = github.repos.list
      repositories.each do |repository|
        r = repository.to_hash
        name = r["name"]
        fullname = r["full_name"]
        
        collection = Hash["name" => name, "fullname" => fullname, "branches" => []]

        branches = github.repos.branches @user.username, name
        branches.each do |branch| 
          b = branch.to_hash
          name = b["name"]

          collection["branches"] << ["name" => name]
        end

        @repositories << collection
      end

    else
      redirect_to root_path
    end
  end
end
