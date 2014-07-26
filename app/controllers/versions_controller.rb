class VersionsController < ApplicationController
  def show
    render :json => Version.find(params[:id])
  end
end
