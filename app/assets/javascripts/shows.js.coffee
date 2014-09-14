$ ->
  $('.datepicker').datetimepicker()

  $('#add_show').on 'click', (e) ->
    e.preventDefault()
    $('#add_show_modal').modal('show')

