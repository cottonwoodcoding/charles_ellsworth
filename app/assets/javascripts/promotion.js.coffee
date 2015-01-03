$ ->
  $('.add-video').on 'click', (e) ->
    $('#add_videos_modal').modal('show')
    if $(@).hasClass('add-main-video')
      $('.mv').attr('selected','selected')
    else if $(@).hasClass('add-vlog-video')
      $('.vv').attr('selected','selected')
    else
      $('.lv').attr('selected','selected')

  $('.vid-thumb').on 'click', (e) ->
    key = $(@).attr('vid-key')
    frame = $(@).parent().parent().find('iframe')
    desc = $(@).parent().parent().find('p')
    desc.text($(@).attr('data-description'))
    frame[0].contentWindow.location.href = "https://www.youtube.com/embed/#{key}"


