# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  timer = null
  $(document).on 'page:change', recordBehavior

recordBehavior = ->
  sendPing = ->
    b = $('#behavior')
    if b.length
      data = {behavior: { status: 0 }} # no sense
      $.post(b.data('url'), data)
    else
      clearInterval(timer)
  b = $('#behavior')
  if b.length
    sendPing()
    timer = setInterval(sendPing, b.data('time')) # every 3s
