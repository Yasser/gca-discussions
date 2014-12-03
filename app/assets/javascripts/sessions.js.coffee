NProgress.configure
  showSpinner: false
  ease: 'ease'
  speed: 500

ready = ->
  $.idleTimer(90000) if $('#modalIdle').length > 0
  
  $(document).on("idle.idleTimer", () ->
    el = $("#modalIdleCounter")
    d = 10000
    inc = 100
    t = $.timer(() ->
      d -= inc
      if d <= inc
        el.html('0') if el.length > 0
        this.stop()
        window.location.replace($("#modalIdle").attr("data-redirect"))
      else
        if el.length > 0
          s = parseInt(d / 1000)
          el.html(s)
    )
    t.set({ time: inc, autostart: true })
    $("#modalIdle").modal({backdrop: 'static', keyboard: false})
    
    $("#modalIdle button").on("click", ()->
      $.idleTimer("reset")
      t.stop()
    )
  )

$(document).ready(ready)
$(document).on('page:load', ready)