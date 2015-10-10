# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'page:change', initAce

initAce = ->
  $('.html-area').ace({ theme: 'monokai', lang: 'liquid', maxLines: 30, minLines: 5 })
