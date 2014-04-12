# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".y-center").css "top", ($(".y-center").parent().parent().height() -
    $(".y-center").height()) / 2
  return
