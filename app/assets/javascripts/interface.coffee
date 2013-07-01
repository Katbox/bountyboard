initializeBounties = ->
  $(".bounty-square > .short-desc").ellipsis()
  $(".bounty-button").button()

$(document).ready initializeBounties
$(document).on "page:load", initializeBounties

