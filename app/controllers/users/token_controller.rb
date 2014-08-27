class Users::TokenController < ApplicationController
  def update
    current_user.authentication_token = nil
    if current_user.save
      redirect_to edit_user_registration_path, flash:         { success: 'Token updated' }
    else
      redirect_to edit_user_registration_path, flash:         { warning: 'Could not update token' }
    end
  end
end
