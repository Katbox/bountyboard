initiate_persona_login = ->
	window.navigator.id.get (assertion) ->
		if assertion
			$('input[name=assertion]').val(assertion)
			$('#browser_id_form').submit()
		else
			window.location = "/sessions_controller#auth_failure"

$(document).ready ->
	$('#browser_id_form button').click ->
		initiate_persona_login()
		false

