(function() {
  $(document).ready(function() {
    $("#filters-dialog-show").click(function(event) {
      var filters_pane;

      filters_pane = $("#filters-controls");
      filters_pane.slideToggle();
      return event.stopPropagation();
    });
    return $(".filters-buttonset").buttonset();
  });

}).call(this);
