ready = ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('.selectpicker').selectpicker()
  if(/Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent))
    $('.selectpicker').selectpicker('mobile')

$(document).ready(ready)
$(document).on('page:load', ready)
