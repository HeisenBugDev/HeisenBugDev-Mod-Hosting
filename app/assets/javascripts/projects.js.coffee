# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '#more-downloads', ->
  $('#downloads').toggleClass('hide')
  if location.hash == '#downloads'
    location.hash = ''
  else
    location.hash = '#downloads'

$(document).on 'click', '#add-dev', ->
  $('#add-dev-form').toggleClass('hide')