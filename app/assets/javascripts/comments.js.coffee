# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.comment-reply').click ->
    $(this).closest('.comment').find('.reply-form').toggle()
    event.preventDefault()
    return
$ ->
  $('.comment-hide').click ->
    $(this).closest('.comment').siblings('.comments-show').toggle()
    if ($(this).html()=="hide")
    	$(this).html("show")
    else
    	$(this).html("hide")
    event.preventDefault()
    return

