class EmberController < ApplicationController
  # This controller does a magical thing. It lets rails pass all non api
  # requests to it so it can render a blank template! We need **a** controller
  # for default routes, it doesn't have to be a fancy one.

  def index
    render text: '', layout: true
  end
end
