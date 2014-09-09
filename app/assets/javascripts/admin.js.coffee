$ ->
  $('#mass-signup-form').submit (e) ->
    e.preventDefault()
    $form = $(@)
    $.ajax
      type: 'POST'
      url: '/admin/signup'
      data: $form.serializeArray()
      success: (data) ->
        alert(data)
        $form[0].reset()
      error: (data) ->
        alert(data.responseText)
        $form[0].reset()
