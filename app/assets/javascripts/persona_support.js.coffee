initiate_persona_login = ->
	window.navigator.id.get (assertion) ->
		if assertion
			$('input[name=assertion]').val(assertion)
			$('#browser_id_form').submit()
		else
			window.location = "/sessions_controller#auth_failure"

$(document).ready ->

	$('.persona-login-button').click ->
		$('#browser_id_form :submit').click()	

	$('#browser_id_form button').click ->
		initiate_persona_login()
		false

