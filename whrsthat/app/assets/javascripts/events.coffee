$ =>	
	$('.new-event').click () =>
		window.document.location = '/events/new'

	$('.submit-invite').click () ->
		$('form.new_event_user').submit()
		return false

	$('#event_user_number').attr('type', 'tel')

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


	$('#event_time_at').datetimepicker()