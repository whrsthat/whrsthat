$ ->

	$('.new-event').click () =>
		window.document.location = '/events/new'

	$('.submit-invite').click () ->
		$('form.new_event_user').submit()
		return false

	$('#event_user_number').attr('type', 'tel')

	$('.demo-card-event .delete').click () ->
		button = $(this)
		ev = $(this).parents('.event')
		$.ajax({
			method: 'delete',
			url: '/events/'+$(ev).attr('data-id')
		})
		.done(() ->
			$(ev).fadeOut()
		)
		return false

	$('.invitation .delete').click () ->
		button = $(this)
		inv = $(this).parents('.invitation')
		$.ajax({
			method: 'delete',
			url: '/events/'+$('meta[name="event-id"]').attr('content')+'/'+$(inv).attr('data-id')
		})
		.done(() ->
			$(inv).remove()
		)
		return false

	$('#event_user_number').keyup((e) =>
		num = $('#event_user_number').val()
		if num.indexOf('+') is -1
			num = "+1#{num}"
			$('#event_user_number').val(num)
	)

	$('#event_switch').change () ->
		if $('#event_switch').is(':checked')
			$('.Events').hide()
			$('.Invitations').show()
			$('.status').text("you've been invited to")
		else
			$('.Events').show()
			$('.Invitations').hide()
			$('.status').text("you've created")
	$('#event_switch').click()

	
	$('#file_input_text_div').click(() -> $('#file_input_file').click())