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

  $('.header-edit').on 'click', (e) ->
    content = $(@).text().trim()
    $('.header-edit').replaceWith ->
      "<div class='text-center'><input id='header_edit_area' class='edit-div' type='text' value='#{$(@).text().trim()}'></input></div>"

  $('.contribution_edit').click ->
    $(@).replaceWith ->
      "<div class='text-center'><input id='contribution_edit_area' type='text' value='#{$(@).text().trim()}'></input></div>"

  $('.donation_label').click ->
    $('.contribution_actions').hide()
    $('.contribution_redirect_message').removeClass('hide')
    $contributionForm = $('#contribution_form')
    $contributionForm.find('#contribution_amount').val($(@).attr('value'))
    $contributionForm.submit()

  $(document).on 'keyup', '#contribution_edit_area', (e) ->
    if e.keyCode == 13
      $.ajax '/update_contribution_text',
        type: 'POST'
        data: {'contribution_text' : $(@).val()}
        success: (data) ->
          window.location.reload()
        error: (data) ->
          alert('Error updating contribution description')

  $('.footer-edit').on 'click', (e) ->
    content = $(@).text().trim()
    $('.footer-edit').replaceWith ->
      "<div class='text-center edit-div'><input id='footer_edit_area' class='edit-div' type='text' value='#{$(@).text().trim()}'></input></div>"

   $(document).on 'keyup', '#header_edit_area', (e) ->
    if e.keyCode == 13
      $.ajax '/update_header_text',
        type: 'POST'
        data: {'header_text' : $(@).val()}
        success: (data) ->
          window.location.reload()
        error: (data) ->
          alert('Error updating header description')

   $(document).on 'keyup', '#footer_edit_area', (e) ->
    if e.keyCode == 13
      $.ajax '/update_footer_text',
        type: 'POST'
        data: {'footer_text' : $(@).val()}
        success: (data) ->
          window.location.reload()
        error: (data) ->
          alert('Error updating header description')

  $('.other_contribution').click ->
    $('#other_contribution_modal').modal('show')

  $('.thermometer').thermometer()
