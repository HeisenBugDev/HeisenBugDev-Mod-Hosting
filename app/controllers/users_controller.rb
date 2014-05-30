class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render :json => @user
  end

  def index
    @users = User.paginate(page: params[:page])
  end
end
