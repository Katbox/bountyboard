$(document).ready ->
  $("#filter-cost").css "display", "none"
  $("#filter-cost-widget").slider
    range: true
    min: 5
    max: 500
    values: [5, 500]
    slide: (event, ui) ->
      $("#filter-cost").val("$" + ui.values[0] + " - $" + ui.values[1])

  $('.filter-control input[type="checkbox"]').button
    create: (event, ui) ->
      console.log "Created a checkbox button."

