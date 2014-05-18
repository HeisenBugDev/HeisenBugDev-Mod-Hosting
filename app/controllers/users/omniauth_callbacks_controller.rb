class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :beta_logged_in

  def github
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_github_oauth(request.env["omniauth.auth"])
    if @user.save
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      # set_flash_message(:notice, :success, :kind => "GitHub") if is_navigational_format?
    else
      redirect_to root_path, :flash => { :warning => "Could not save user." }
    end
  end
end