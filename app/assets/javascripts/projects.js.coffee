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
  $('#add-dev-form').fadeToggle(50)
  $('input#project_users').focus()

$(document).on 'ready page:load', ->
  $('#add-dev-form').on 'ajax:success', (e, data, status, xhr) ->
    $('input#project_users').val('')

$(document).on "click", (e) ->
  formClick = $("#add-dev-form").has($(e.target)).length || $(e.target).is("#add-dev")
  $("#add-dev-form").hide(0) unless formClick

$(document).on "keydown", "textarea", (e) ->
  $(this).parents("form").submit()  if e.keyCode is 13 and (e.metaKey or e.ctrlKey)

$(document).foundation('reveal', {animation_speed: 100})

$ ->
  $(document).on 'ready page:load', ->
    $('span[class$=-repo]').parent().mouseover ->
      $(this).width($(this).find('span').width() + 20) if $(this).find('span').width() > 220
    $('span[class$=-repo]').parent().mouseout ->
      $(this).css('width', '') if $(this).width() > 220
