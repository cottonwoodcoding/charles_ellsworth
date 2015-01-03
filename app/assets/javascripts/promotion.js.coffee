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

  $('.promo-intro').on 'click', (e) ->
    $('.promo-intro').replaceWith ->
      '<input class="center header-input" type="text" maxlength="255" /><button class="btn btn-primary">Save</button>'

  $('.contribution_edit').click ->
    $(@).replaceWith ->
      "<div class='text-center'><input id='contribution_edit_area' type='text' value='#{$(@).text()}'></input></div>"

  $(document).on 'keyup', '#contribution_edit_area', (e) ->
    if e.keyCode == 13
      $.ajax '/update_contribution_text',
        type: 'POST'
        data: {'description' : $(@).val()}
        success: (data) ->
        error: (data) ->
          alert('Error updating contribution description')


