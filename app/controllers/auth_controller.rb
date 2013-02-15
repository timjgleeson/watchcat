class AuthController < ApplicationController
  def login
    github = Github.new :client_id => '67571272d259e02785b1', :client_secret => '2150317f07f6517f1cf6e847b5c51c70df5a6105'
    address = github.authorize_url :redirect_uri => 'http://watchmen.dev/auth/callback', :scope => 'repo'
    redirect_to address
  end

  def callback
    github = Github.new :client_id => '67571272d259e02785b1', :client_secret => '2150317f07f6517f1cf6e847b5c51c70df5a6105'
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
end
