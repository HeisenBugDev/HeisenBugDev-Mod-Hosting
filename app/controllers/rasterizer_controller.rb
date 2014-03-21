class RasterizerController < ApplicationController
  skip_before_filter :verify_authenticity_token
  include RasterizerHelper

end
