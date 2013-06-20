$(document).ready ->
  if $("body").data("page") is "Bounties#index"

    # set up the filters controls
    $("#filter-cost").css "display", "none"
    $("#filter-cost-widget").slider
      range: true
      min: 5
      max: 500
      values: [5, 500]
      slide: (event, ui) ->
        $("#filter-cost").val("$" + ui.values[0] + " - $" + ui.values[1])
  
    $('.filter-control input[type="checkbox"]').button()

    # set up the bounty display
    $("#bounty-list").masonry
      itemSelector: ".bounty-square"
      columnWidth: 100
      gutterWidth: 5
      isAnimated: true
      isFitWidth: true

