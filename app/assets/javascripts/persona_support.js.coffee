$(document).ready ->

  navigator.id.watch(
    onlogin: (assertion) ->

	  # if the user is already logged in, don't re-login
	  # note that this detection logic assumes there is at least one login
	  # button on the page when a user isn't logged in
      if($('.persona-login-button').length == 0)
        return

      $.ajax(
        type: "POST"
        url: "/auth/browser_id/callback"
        data: { assertion: assertion }
        success: ->
          location.reload()
        error: (xhr, status_string, error_message) ->
          # DEBUG
          alert "Failure function called after login POST.\n#{status_string}: #{error_message}"
      )
    onlogout: ->
      $.ajax(
        type: "POST"
        url: "/sign_out"
        success: ->
          location.reload()
        error: (xhr, status_string, error_message) ->
          # DEBUG
          alert "Failure function called after logout POST.\n#{status_string}: #{error_message}"
      )
  )

  # attach a click handler to login buttons that initiates the Persona login
  # process
  $('.persona-login-button').click ->
    # TODO: add a siteLogo: "URL" property to show the user our site's logo
    # when logging in with Persona
    # note that Persona REQUIRES https on the hosting site when loading logos
    navigator.id.request
      siteName: "The Bounty Board"

