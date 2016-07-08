this.remove_fields = (link) ->
  $(link).prev('input[type=hidden]').val '1'
  $(link).closest('.fields').hide()
  return

this.add_fields = (link, association, content) ->
  new_id = (new Date).getTime()
  regexp = new RegExp('new_' + association, 'g')
  $(link).parent().before content.replace(regexp, new_id)
  return

 $(document).ready ->
   $('.new-question').click ->
    $('#newquestion').slideToggle 'fast'
    return

$(document).ready ->
  $('#search').click ->
    $('#form_search').slideToggle()
    return

$(document).ready ->
  setTimeout (->
    $('.flash').slideUp 'slow'
    return
  ), 1500
  return

$(document).on 'ready page:load', ->
  clock = $('#clock')
  status = clock.attr('data-status')
  time_limit = clock.attr('data-time-limit')
  time_start = clock.attr('data-time-start')
  time_now = clock.attr('data-time-now')
  time = time_limit * 60 - (time_now - time_start)
  setInterval (->
    `var hour`
    `var min`
    `var sec`
    if time > 0 and status != 'uncheck' and status != 'checked'
      c = time--
      h = c / 3600 >> 0
      if h.toString().length > 1
        hour = '' + h
      else
        hour = '0' + h
      m = (c - (h * 3600)) / 60 >> 0
      if m.toString().length > 1
        min = '' + m
      else
        min = '0' + m
      s = c - (m * 60 + h * 3600) >> 0
      if s.toString().length > 1
        sec = '' + s
      else
        sec = '0' + s
      clock.text hour + ':' + min + ':' + sec
    else
      if status == 'testing'
        $('#finish').click()
      clock.text '00:00:00'
    return
  ), 1000
  return

make_radio_from_checkbox = ->
  $('.radio_answer').click ->
    if $('#question_question_type').val() == 'single'
      $('.radio_answer').not(this).attr 'checked', false
    return
  $('#question_question_type').on 'change', ->
    $('.radio_answer').attr 'checked', false
    return
  return

ready = ->
  $('body').on 'DOMNodeInserted', ->
    make_radio_from_checkbox()
    return
  return

$(document).ready ready
$(document).on 'page:load', ready
$(document).on 'page:load', make_radio_from_checkbox

jQuery ->
  $.ajax
    url: 'https://apis.google.com/js/client:plus.js?onload=gpAsyncInit'
    dataType: 'script'
    cache: true

window.gpAsyncInit = ->
  gapi.auth.authorize {
    immediate: true
    response_type: 'code'
    cookie_policy: 'single_host_origin'
    client_id: 'YOUR_CLIENT_ID'
    scope: 'email profile'
  }, (response) ->
    return
  $('.googleplus-login').click (e) ->
    e.preventDefault()
    gapi.auth.authorize {
      immediate: false
      response_type: 'code'
      cookie_policy: 'single_host_origin'
      client_id: 'YOUR_CLIENT_ID'
      scope: 'email profile'
    }, (response) ->
      if response and !response.error
        jQuery.ajax
          type: 'POST'
          url: '/auth/google_oauth2/callback'
          data: response
          success: (data) ->
            return
      else
      return
    return
  return
