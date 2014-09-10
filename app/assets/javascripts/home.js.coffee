$ ->
  window.onload = ->
    if window.location.pathname == '/'
      $('#registration_modal').modal('show')
      $.ajax '/home/update_latest',
        type: 'GET'
        success: (data) ->
          $('.latest-content').append(data)

  $window = $(window)
  $("section[data-type=\"background\"]").each ->
    $bgobj = $(this)
    $(window).scroll ->
      yPos = -($window.scrollTop() / $bgobj.data("speed"))

      coords = "50% " + yPos + "px"
      $bgobj.css backgroundPosition: coords

