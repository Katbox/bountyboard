# call this method any time the bounty list is reloaded
window.refresh_bounties = ->
  $(".bounty-square > .short-desc").ellipsis()
  $(".bounty-button").button()
  $("#bounty-list").masonry("reload")


initialize_bounties = ->
  $(".bounty-square > .short-desc").ellipsis()
  $(".bounty-button").button()

  # set up the bounty display
  $("#bounty-list").masonry
    itemSelector: ".bounty-square"
    columnWidth: 100
    gutterWidth: 5
    isAnimated: true
    isFitWidth: true

$(document).ready initialize_bounties
$(document).on "page:load", initialize_bounties

