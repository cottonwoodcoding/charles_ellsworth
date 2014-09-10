$ ->

  submitMailingListForm = (form, closeModal) ->
    $form = $(form)
    $.ajax
      type: 'POST'
      url: '/mailing_list/signup'
      data: $form.serializeArray()
      success: (data) ->
        alert(data)
        $form[0].reset()
        $('#registration_modal').modal('hide') if closeModal
      error: (data) ->
        alert(data.responseText)
        $form[0].reset()

  $('#mass-signup-form').submit (e) ->
    e.preventDefault()
    submitMailingListForm(@, false)

  $('#registration_form').submit (e) ->
    e.preventDefault()
    submitMailingListForm(@, true)
