class DashboardController < ApplicationController
  def index
    if cookies[:token]
      github = Github.new :oauth_token => cookies[:token]

      @user = User.find_by_github_id(github.users.get.id)
      @edit = params[:edit].to_i || nil
    else
      redirect_to root_path
    end
  end
end
