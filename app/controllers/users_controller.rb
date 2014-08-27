class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    render json: @user
  end

  def index
    @users = User.paginate(page: params[:page])
    render json: @users
  end
end
