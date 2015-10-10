# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'page:change', formUpdate

formUpdate = ->
  $("div.error").each ->
    name = $(@).data('name')
    $("[name=" + name + "]").each ->
      $(@).closest('.form-group').addClass('has-error')

  $("div.submitted").each ->
    name = $(@).data('name')
    value = $(@).data('value')
    $("[name=" + name + "]").each ->
      if $(@).attr('type') == 'radio' or $(@).attr('type') == 'checkbox'
        $(@).val([value])
      else
        $(@).val(value)
