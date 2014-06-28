class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :beta_logged_in

  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"])
    if @user.save
      # this will throw if @user is not activated
      sign_in @user, :event => :authentication
      @user.save
      params[:omni] = request.env["omniauth.auth"]
      session[:user_id] = @user.id
      # redirect_to root_path
      # _and_redirect @user, :event => :authentication
    else
      # redirect_to root_path, :flash => { :warning => "Could not save user." }
      render :text => 'ohno'
    end
  end
end