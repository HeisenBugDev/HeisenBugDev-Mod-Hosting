# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
yAlign = ->
  $(".y-center").css "top", ($(".y-center").parent().parent().height() -
    $(".y-center").height()) / 2

hiddenData = ->
  $('.more-artifacts').toggle()
  $('.more-artifacts-toggle').text('More')

readyCalls = ->
  yAlign()
  hiddenData()

$(document).ready(readyCalls)
$(document).on('page:load', readyCalls)

$(document).on 'click', '.more-artifacts-toggle', ->
  $(this).prev(".more-artifacts").toggle("slide", { direction: "right" })

  $(this).toggleClass 'fi-plus'
  $(this).toggleClass 'fi-minus'

  if $(this).text() == 'More'
    $(this).text('Less')
  else
    $(this).text('More')