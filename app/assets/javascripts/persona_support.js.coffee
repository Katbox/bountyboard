initiate_persona_login = ->
	window.navigator.id.get (assertion) ->
		if assertion
			$('input[name=assertion]').val(assertion)
			$('#browser-id-form').submit()
		else
			alert("Your browser is too old to use the login form.\n" +
				"Please update your browser to the latest version if you want to sign in.")

$(document).ready ->

	$('.persona-login-button').click ->
		$('#browser-id-form :submit').click()	

	$('#browser-id-form button').click ->
		initiate_persona_login()
		false

