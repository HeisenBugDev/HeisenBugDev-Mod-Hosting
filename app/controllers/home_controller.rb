class HomeController < ApplicationController
  skip_before_filter :beta_logged_in

  def index
    puts "current user name #{current_user.name}"
  end
end
