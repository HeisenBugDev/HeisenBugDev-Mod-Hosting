class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  before_filter :beta_logged_in
  after_filter :flash_to_headers

  private
  def beta_logged_in
    unless Rails.env.test?
      render :text => 'Closed beta only. Visit HeisenBugDev/HeisenBugDev
      on GitHub to request access.' if current_user.nil?
    end
  end

  def flash_to_headers
    return unless request.xhr?
    msg = flash_message
    # replace german umlaute encoded in utf-8 to html escaped ones
    msg = msg.gsub('ä', '&auml;').gsub('ü', '&uuml;').gsub('ö', '&ouml;').
      gsub('Ä', '&Auml;').gsub('Ü', '&Uuml;').gsub('Ö', '&Ouml;').
      gsub('ß', '&szlig;')
    response.headers['X-Message'] = msg
    response.headers['X-Message-Type'] = flash_type.to_s
    flash.discard # don't want the flash to appear when you reload page
  end

  def flash_message
    [:error, :warning, :notice].each do |type|
      return flash[type] unless flash[type].blank?
    end
    # if we don't return something here, the above code will return 'error,
    # warning, notice'
    ''
  end

  def flash_type
    # :keep will instruct the js to not update or remove the shown message.
    # just write flash[:keep] = true (or any other value)
    # in your controller code
    [:error, :warning, :notice, :keep].each do |type|
      return type unless flash[type].blank?
    end
    # don't return the array from above which would happen if we don't have an
    # explicit return statement returning :empty will also allow you to easily
    # know that no flash message was transmitted
    :empty
  end
end
