# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
yAlign = (clazz) ->
  value = ($(".y-center#{clazz}").parent().parent().outerHeight() - $(".y-center#{clazz}").outerHeight()) / 2
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
    # ctx.scale window.devicePixelRatio, window.devicePixelRatio

  ctx.webkitImageSmoothingEnabled = false
  ctx.imageSmoothingEnabled = false
  ctx.mozImageSmoothingEnabled = false

  ctx.drawImage $(this)[0], 0, 0, canvas.width, canvas.height
  $(this)[0].parentNode.replaceChild canvas, $(this)[0]
  yAlign('.mod-download-icon.no-aa-image')

removeAA = ->
  $(".no-aa-image").each (i, img) ->
    img.onload = imageToCanvas

readyCalls = ->
  removeAA()
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
