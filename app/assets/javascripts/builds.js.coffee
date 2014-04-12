# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
yAlign = ->
  value = ($(".y-center").parent().parent().height() -
    $(".y-center").height()) / 2
  $(".y-center").css "top", value
  return

$(document).on('ready page:load', yAlign)