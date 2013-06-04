$(document).ready ->

  # set up the button that shows and hides the filters controls
  $("#filters-dialog-show").click (event) ->
    filters_pane = $("#filters-controls")
    filters_pane.stop(true, true)
    filters_pane.slideToggle null, ->
      # This should not be necessary, but for some reason a second slide toggle
      # animation is performed when the first is completed (but only if the
      # slide toggle is hiding the element--only the desired slide toggle
      # happens when showing the element). I've verified that this extra
      # animation isn't coming from the click handler being fired multiple
      # times due to event propagation, or the click handler being somehow
      # bound to the button multiple times. I can find no explanation for this
      # behavior and the only reliable fix is to manually stop the second
      # animation.
      filters_pane.stop(true, true)
    event.stopPropagation()

