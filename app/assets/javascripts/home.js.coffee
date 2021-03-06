$ ->
  load_data = ->
    if window.location.pathname == '/' or window.location.pathname == '/home'
      unless window.location.hash == '#latest'
        $.ajax
          type: 'GET'
          url: '/mailing_list/signed_up'
          success: (data) ->
            if data == 'not signed up'
              $('#registration_modal').modal 'show'

      width = $(window).width()
      $.ajax '/home/update_latest',
        type: 'GET'
        data:
          width: width
        success: (data) ->
          $('.latest-content').append(data)
          $('.spinner').remove()


  init = load_data()
  window.onload = init

  $window = $(window)
  $("section[data-type=\"background\"]").each ->
    $bgobj = $(this)
    $(window).scroll ->
      yPos = -($window.scrollTop() / $bgobj.data("speed"))

      coords = "50% " + yPos + "px"
      $bgobj.css backgroundPosition: coords
