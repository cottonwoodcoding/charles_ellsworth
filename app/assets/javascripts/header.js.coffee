$ ->
  $('#mailing_list').on 'click', (e) ->
    e.preventDefault()
    $('#registration_modal').modal 'show'
