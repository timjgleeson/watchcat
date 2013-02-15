class WelcomeController < ApplicationController
  def index
    if cookies[:token]
      redirect_to dashboard_path
    else
      
    end
  end
end
