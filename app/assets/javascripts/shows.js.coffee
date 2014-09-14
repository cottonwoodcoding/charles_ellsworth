$ ->
  $('.datepicker').datetimepicker()

  $('#add_show').on 'click', (e) ->
    e.preventDefault()
    $('#add_show_modal').modal('show')

  $('#door').on 'click', ->
    $('#ticket_group').addClass('hidden')
  $('#free_show').on 'click', ->
    $('#ticket_group').addClass('hidden')
  $('#ticket_url').on 'click', ->
    $('#ticket_group').removeClass('hidden')

  $('.remove-show').on 'click', (e) ->
    e.preventDefault()
    id = $(@).parent().parent().data('id')
    el = $(@)
    $.ajax 'shows/delete',
      type: 'POST'
      data:
        id: id
      success: ->
        window.location.reload()

  $('.edit-show').on 'click', (e) ->
    e.preventDefault()
    row = $(@).parent().parent()
    date = row.find('#date_field').text().trim()
    venue = row.find('#venue_field').text().trim()
    location = row.find('#location_field').text().trim()
    option = row.find('#purchase_option').text().trim()
    id = row.data('id')
    $('#add_show_modal').modal('show')
    $('#modal_title').text('Edit Show')
    $('#edit_id').val(id)
    $('#date_picker').val(date)
    $('#venue').val(venue)
    $('#location').val(location)
    $('.radio input').removeAttr('checked')
    $('#ticket_group').addClass('hidden')
    switch option
      when 'Free Show'
        $('#free_show').attr('checked', 'checked')
      when 'Tickets'
        el = $('#ticket_url')[0]
        el.checked = true
        $('#ticket_url').attr('checked', 'checked')
        $('#ticket_group').removeClass('hidden')
        ticket_url = row.find('#purchase_option a').attr('href')
        $('#tickets').val(ticket_url)
      when 'At The Door'
        $('#door').attr('checked', 'checked')
      else
        $('#contact').attr('checked', 'checked')

  $('#add_show_modal').on 'hide.bs.modal', ->
    $('#modal_title').text('Add Show')
    $('#add_show_form').reset()

