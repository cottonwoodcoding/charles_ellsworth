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

  window.onload = ->
    if window.location.pathname == '/media'
      $('.carousel-control').addClass('hidden')
      $.ajax '/media/albums',
        type: 'GET'
        success: (data) ->
          k = _.keys(data)
          first = data[k[0]]
          photos = first.photos
          for p, index in photos
            source = p.parsed_body.content.src
            selected = 'not-selected'
            selected = 'active' if index == 0
            $('#photo-carousel #inner').append("<div class='item #{selected}'><img src='#{source}'></div>")

          $('#photo-carousel #inner').append("<div class='item #{selected}'><img src='#{p}'></div>")


          $(".carousel").carousel interval: 4000

          $(document).on 'click', '.prev-button', (e) ->
            $('.carousel').carousel('prev')

          $(document).on 'click', '.next-button', (e) ->
            $('.carousel').carousel('next')

          $('.carousel-control').removeClass('hidden')

          for a in _.pairs(data)
            id = a[0]
            name = a[1].name
            $('#photo_album_list').append("<li><a id='#{id}' class='album-link' href='#'>>> #{name}</a></li>")

  $(document).on 'click', '.album-link', (e) ->
    $('.carousel-control').addClass('hidden')
    e.preventDefault()
    el = $(@)
    $.ajax '/media/update_photos',
      type: 'GET'
      data:
        id: el.attr('id')
      success: (data) ->
        $('.carousel').carousel('pause').removeData()
        $('#photo-carousel #inner').empty()
        for p, index in data.photos
          selected = 'not-selected'
          selected = 'active' if index == 0
          $('#photo-carousel #inner').append("<div class='item #{selected}'><img src='#{p}'></div>")
        $('.carousel').carousel interval: 4000
        $('.carousel-control').removeClass('hidden')

  $('.why_donate').on 'click', ->
    $('.why_donate').popover('toggle')
