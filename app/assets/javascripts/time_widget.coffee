updateTimers = ->
  console.dir("Updating timers")
  $(".time-widget").each ->

    id = $(this).data("team-id")
    url = $(this).data("done-url")

    h0 = $(this).data("h")
    m0 = $(this).data("m")
    s0 = $(this).data("s")
    d0 = $(this).data("d")
    n0 = $(this).data("n")

    d = d0
    h = h0
    m = m0
    s = s0 - 1
    n = n0 + 1

    if (s < 0)
      s += 60
      m -= 1
    if (m < 0)
      m += 60
      h -= 1
    if (h < 0)
      h += 24
      d -= 1

    $(this).data("h", h)
    $(this).data("m", m)
    $(this).data("s", s)
    $(this).data("d", d)
    $(this).data("n", n)
    $(this).attr("data-h", h)
    $(this).attr("data-m", m)
    $(this).attr("data-s", s)
    $(this).attr("data-d", d)
    $(this).attr("data-n", n)
    $(this).html((if d > 0 then "" + d + "d " else "") + (if h > 9 then "" else "0") + h + ":" + (if m > 9 then "" else "0") + m + ":" + (if s > 9 then "" else "0") + s)

    if d < 0 && url?.length
      window.location = url

    if n > 120 && id && ((id + 0) > 0)
      $(this).attr("data-n", 0)
      $(this).data("n", 0)
      console.log("Updating via ajax - " + id)
      e = $(this)
      url = "/update-time-widget/" + id
      $.ajax url,
        type: 'GET'
        dataType: 'html'
        error: (jqXHR, textStatus, errorThrown) ->
          console.log "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) ->
          console.log "Successful AJAX call: #{data}"
          e.replaceWith data

$ ->
  window.setInterval(updateTimers, 1000)