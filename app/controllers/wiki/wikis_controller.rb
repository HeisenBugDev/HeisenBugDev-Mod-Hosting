class Wiki::WikisController < ApplicationController
  def show
    render json: Wiki::Wiki.find(params[:id])
  end
end
