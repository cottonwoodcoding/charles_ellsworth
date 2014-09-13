$ ->
  $('#contactForm').submit (e) ->
    e.preventDefault()
    $form = $(@)
    $.ajax
      type: 'POST'
      url: '/contact/contact'
      data: $form.serializeArray()
      success: (data) ->
        $form[0].reset()
        bootbox.alert(data)
      error: (data) ->
        bootbox.alert(data)