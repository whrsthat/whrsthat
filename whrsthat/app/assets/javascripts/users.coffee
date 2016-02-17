# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#user_password').attr('type', 'password')

	$('.create').click () ->
		window.document.location = '/users/new'
		return false
		
	$('#user_phone').keyup((e) =>
		num = $('#user_phone').val()
		if num.indexOf('+') is -1
			num = "+1#{num}"
			$('#user_phone').val(num)
	)

	$('.google').click () ->
		window.document.location = '/auth/google_oauth2'