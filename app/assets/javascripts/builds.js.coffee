# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
yAlign = (clazz) ->
  value = ($(".y-center#{clazz}").parent().parent().parent().parent().outerHeight() - $(".y-center#{clazz}").outerHeight()) / 2
  $('.y-center').css 'top', value

hiddenData = ->
  $('.more-artifacts').toggle()
  $('.more-artifacts-toggle').text('More')

imageToCanvas = ->
  canvas = document.createElement("canvas")
  canvas.className = this.className
  ctx = canvas.getContext("2d")
  if window.devicePixelRatio
    hidefCanvasWidth = $(canvas).attr("width")
    hidefCanvasHeight = $(canvas).attr("height")
    hidefCanvasCssWidth = hidefCanvasWidth
    hidefCanvasCssHeight = hidefCanvasHeight
    $(canvas).attr "width", hidefCanvasWidth * window.devicePixelRatio
    $(canvas).attr "height", hidefCanvasHeight * window.devicePixelRatio
    $(canvas).css "width", hidefCanvasCssWidth
    $(canvas).css "height", hidefCanvasCssHeight

  ctx.webkitImageSmoothingEnabled = false
  ctx.imageSmoothingEnabled = false
  ctx.mozImageSmoothingEnabled = false

  ctx.drawImage $(this)[0], 0, 0, canvas.width, canvas.height
  $(this)[0].parentNode.replaceChild canvas, $(this)[0]
  yAlign('.mod-download-icon.no-aa-image')

removeAA = ->
  $(".no-aa-image").each (i, img) ->
    img.onload = imageToCanvas

hideBugged = ->
  $('.bugged').addClass 'hide'

readyCalls = ->
  removeAA()
  yAlign()
  hiddenData()
  hideBugged()

  $('.artifact-link').click (e) ->
    return true if $(e.target).is('#more-downloads')
    href = $(this).attr('href')
    $.ajax({url: $(this).attr('download_counter_url')}).done ->
      window.location.href = href
    false

  $('#bug-toggler').click ->
    $('.bugged').toggle()

$(document).on('ready page:load', readyCalls)
