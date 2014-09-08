$ ->
  window.onload = ->
    if window.location.pathname == '/'
      $('#registration_modal').modal('show')
