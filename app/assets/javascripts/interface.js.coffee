# call this method any time the bounty list is reloaded
window.refresh_bounties = ->
  $(".bounty-square > .short-desc").ellipsis()
  $(".bounty-button").button()
  $("#bounty-list").masonry("reload")
  resize_names()



initialize_bounties = ->
  $(".bounty-square > .short-desc").ellipsis()
  $(".bounty-button").button()
  resize_names()

resize_names = ->
  $(".bounty-square .name").each ->
      name_length = $(this).text().length
      font_size_num = 280 - (name_length * 3.5)
      font_size = "#{font_size_num}%"
      $(this).css("font-size", font_size)
      $(this).css("line-height", "95%")

  # set up the bounty display
  $("#bounty-list").masonry
    itemSelector: ".bounty-square"
    columnWidth: 100
    gutterWidth: 5
    isAnimated: true
    isFitWidth: true

$(document).ready initialize_bounties
$(document).on "page:load", initialize_bounties

