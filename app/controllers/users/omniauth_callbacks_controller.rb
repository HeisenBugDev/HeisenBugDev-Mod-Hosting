class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :beta_logged_in

  def github
    @user = User.find_for_github_oauth(request.env['omniauth.auth'])
    if @user.save
      # this will throw if @user is not activated
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to root_path, flash: { warning: 'Could not save user.' }
    end
  end
end
