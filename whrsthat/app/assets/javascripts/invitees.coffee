# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ =>
	$('.accept').click(() ->
		$(this)
			.parents('.mdl-cell--6-col')
				.siblings()
					.hide()
				.end()
			.removeClass('mdl-cell--6-col')
			.addClass('mdl-cell--12-col')
		$(this).attr('disabled', 'true')
		$('.decline').hide()
		$('.status').text("You accepted this event")
		$('.view').show()
		$.post(window.document.location.toString()+'/respond', { accepted: 'true' })
	)

	$('.decline').click(() ->
		$(this)
			.parents('.mdl-cell--6-col')
				.siblings()
					.hide()
				.end()
			.removeClass('mdl-cell--6-col')
			.addClass('mdl-cell--12-col')
		$(this).attr('disabled', 'true')
		$('.accept').hide()	
		$('.status').text("You declined this event")

		$.post(window.document.location.toString()+'/respond', { accepted: 'false' })
	)