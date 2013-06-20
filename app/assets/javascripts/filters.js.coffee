$(document).ready ->
  if $("body").data("page") is "Bounties#index"
    $("#filter-cost").css "display", "none"
    $("#filter-cost-widget").slider
      range: true
      min: 5
      max: 500
      values: [5, 500]
      slide: (event, ui) ->
        $("#filter-cost").val("$" + ui.values[0] + " - $" + ui.values[1])
  
    $('.filter-control input[type="checkbox"]').button()

