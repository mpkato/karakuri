# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(document).on 'page:change', initAce
  $(document).on 'page:change', initPreviewButton

initAce = ->
  $('.html-area').ace({ theme: 'monokai', lang: 'liquid', maxLines: 30, minLines: 5 })

initPreviewButton = ->
  task_template_preview = ->
    $('#preview_content').html("Loading ...")
    $('#preview').modal()
    formvals = $('#new_task_template').serializeArray()
    formvals.push({name: 'preview', value: 'Preview'})
    $('#preview_content')
      .load($("#new_task_template").attr('action') + ' #preview_source', formvals)

  if($("#preview_button").length)
    $("#preview_button").click(task_template_preview)
