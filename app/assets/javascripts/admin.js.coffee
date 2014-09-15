$ ->
  $('#comma_button').click ->
    $('#emails').hide()
    $('#comma_emails').removeClass('hide')
    $(@).addClass('hide')
    $('#email_list_button').removeClass('hide')

  $('#email_list_button').click ->
    $(@).addClass('hide')
    $('#comma_button').removeClass('hide')
    $('#emails').show()
    $('#comma_emails').addClass('hide')
