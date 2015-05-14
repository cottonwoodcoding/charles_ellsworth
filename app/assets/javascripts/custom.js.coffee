$ ->
  if $('.info').is(':visible') || $('.error').is(':visible') || $('.success').is(':visible')
    window.setTimeout (->
      $('.info, .error, .success').fadeTo(500,0).slideUp 500, ->
        $(@).remove()
    ), 3000
