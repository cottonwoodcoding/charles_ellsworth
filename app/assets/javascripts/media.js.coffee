$ ->
  $(document).scroll ->
    if window.location.pathname == '/media'
      y = $(@).scrollTop()
      x = $(".media-container").position()
      if y > x.top
        $(".media-bar").fadeIn().css
          position: "fixed"
          top: "0"
        $('.media-link').removeClass('black')
        $('.media-link').addClass('white')
        $('.media-bar').addClass('back-bar')
        $('.media-link i').addClass('fa-2x')
        $('#top_link').removeClass('hidden')
      else
        $(".media-bar").css position: "static"
        $('.media-link').removeClass('white')
        $('.media-link').addClass('black')
        $('.media-bar').removeClass('back-bar')
        $('.media-link i').removeClass('fa-2x')
        $('#top_link').addClass('hidden')

  $window = $(window)
  $("section[data-type=\"background\"]").each ->
    $bgobj = $(this)
    $(window).scroll ->
      yPos = -($window.scrollTop() / $bgobj.data("speed"))

      coords = "50% " + yPos + "px"
      $bgobj.css backgroundPosition: coords

