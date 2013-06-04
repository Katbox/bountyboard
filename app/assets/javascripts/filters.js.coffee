$(document).ready ->

  # set up the button that shows and hides the filters controls
  $("#filters-dialog-show").click (event) ->
    filters_pane = $("#filters-controls")
    filters_pane.slideToggle null, ->
      # prevent animations from piling up
      filters_pane.stop(true, true)
    event.stopPropagation()

  # initialize all buttonsets used by the filter controls
  $(".filters-buttonset").buttonset()

