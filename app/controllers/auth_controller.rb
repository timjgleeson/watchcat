class AuthController < ApplicationController
  def login
    github = Github.new :client_id => ENV['GITHUB_ID'], :client_secret => ENV['GITHUB_SECRET']
    address = github.authorize_url :redirect_uri => ENV['GITHUB_URL'], :scope => 'repo'
    redirect_to address
  end

  def logout
    cookies.delete :token
    redirect_to root_path
  end

  def callback
    github = Github.new :client_id => ENV['GITHUB_ID'], :client_secret => ENV['GITHUB_SECRET']
    
    status = params['error'] || 'success'
    authorization_code = params['code'] || nil

    if status == 'success' && authorization_code != nil
      access_token = github.get_token authorization_code
      token = access_token.token
      cookies[:token] = { :value => token, :expires => 2.weeks.from_now }

      github = Github.new :oauth_token => cookies[:token]
      github_user = github.users.get
      user = User.find_or_initialize_by_github_id(github_user.id)
      user.update_attributes :username => github_user.login, :name => github_user.name, :github_id => github_user.id, :avatar_url => github_user.avatar_url, :token => token

      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  def repositories
    render json: Auth.repositories(cookies[:token])
  end

  def branches
    render json: Auth.branches(cookies[:token], params[:username], params[:repository])
  end

  def repositories_and_branches
    render json: Auth.repositories_and_branches(cookies[:token], params[:username])
  end
end
