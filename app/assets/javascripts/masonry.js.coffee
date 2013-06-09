$(document).ready ->

  $("#bounty-list").masonry
    itemSelector: ".bounty-square"
    columnWidth: 100
    gutterWidth: 5
    isAnimated: true
    isFitWidth: true
