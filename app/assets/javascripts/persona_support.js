(function() {
  $(document).ready(function() {
    $(".persona-login-button").button();
    navigator.id.watch({
      onlogin: function(assertion) {
        if ($('.persona-login-button').length === 0) {
          return;
        }
        return $.ajax({
          type: "POST",
          url: "/auth/browser_id/callback",
          data: {
            assertion: assertion
          },
          success: function() {
            return location.reload();
          },
          error: function(xhr, status_string, error_message) {
            return console.log("Failure function called after login POST.\n" + status_string + ": " + error_message);
          }
        });
      },
      onlogout: function() {
        return $.ajax({
          type: "POST",
          url: "/sign_out",
          success: function() {
            return location.reload();
          },
          error: function(xhr, status_string, error_message) {
            return console.log("Failure function called after logout POST.\n" + status_string + ": " + error_message);
          }
        });
      }
    });
    return $('.persona-login-button').click(function() {
      return navigator.id.request({
        siteName: "The Bounty Board"
      });
    });
  });

}).call(this);
