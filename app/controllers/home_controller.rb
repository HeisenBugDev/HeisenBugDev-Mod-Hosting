class HomeController < ApplicationController
  skip_before_filter :beta_logged_in
end
