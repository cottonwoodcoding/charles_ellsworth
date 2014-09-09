$ ->
  window.onload = ->
    if window.location.pathname == '/'
      $('#registration_modal').modal('show')
      $.ajax '/home/update_latest',
        type: 'GET'
        success: (data) ->
          $('.latest-content').append(data)
