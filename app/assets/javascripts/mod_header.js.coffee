# $(".accordion").on "click", "dd", (event) ->
#   $("dd.active").find(".content").slideToggle "slow"
#   $(this).find(".content").slideToggle "slow"

$(document).on 'click', '.refresh-button', ->
  show_ajax_message 'Queuing a refresh...', 'notice'
  $('#edit-project').foundation('dropdown', 'close', $('#edit-project'))