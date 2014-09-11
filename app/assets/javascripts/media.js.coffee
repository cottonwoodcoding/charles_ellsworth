$ ->
  $(document).scroll ->
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

  soundManager.setup({
    url: '/vendor/assests/flash/swf/',
    flashVersion: 9,
    preferFlash: false
  })

  soundManager.createSound({
    id: 'audio1',
    url: '/public/audio/another_log_on_the_fire.mp3',
    autoLoad: true,
    autoPlay: false,
    volume: 50
  })


