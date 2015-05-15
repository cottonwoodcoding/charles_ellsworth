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
      $(".carousel").carousel interval: 4000

      $(document).on 'click', '.prev-button', (e) ->
        $('.carousel').carousel('prev')

      $(document).on 'click', '.next-button', (e) ->
        $('.carousel').carousel('next')

      $('.carousel-control').removeClass('hidden')

  $(document).on 'click', '.album-link', (e) ->
    e.preventDefault()
    $('.carousel').carousel('pause').removeData()
    $('#inner.carousel-inner').empty()
    count = 0
    for src in $(@).data('images').split(',')
      active = ' not-active'
      active = ' active' if count == 0
      $('#inner.carousel-inner').append("<div class='item#{active}'><img src='http://#{src}'></div>")
      count += 1
    $('.carousel').carousel interval: 4000

  $('.why_donate').on 'click', ->
    $('.why_donate').popover('toggle')

  $('#donation').on 'change', ->
    donationValue = $(@).val()
    parsed = parseInt(donationValue)
    $total = $('#total')
    if parsed != 'NaN' && parsed >= 0
      $total.html("Total:  $#{10 + parsed}")
    else
      $(@).val('0')
      $total.html("Total: $10")

  $('.catalog-content form').on 'submit', (e) ->
    $submitButton = $(@).find('#purchase')
    $submitButton.attr('disabled', 'disabled')
    $submitButton.html('Submitting...')
    e.preventDefault()
    total = parseInt($('#donation').val()) + 10
    data = $(@).serializeArray()
    console.log data
    data.push({'name' : 'total', 'value' : total})
    $.ajax '/media/purchase',
      type: 'POST'
      data: data
      success: (data) ->
        window.location = data
      error: (data) ->
        alert 'error'
        $submitButton.removeAttr('disabled')
        $submitButton.html('Purchase')
        console.log data

  $('#confirm_button').click ->
    $(@).html('Purchasing...')
    $(@).attr('disabled', 'disabled')
    $('#confirm_purchase').submit()

