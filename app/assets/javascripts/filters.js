(function() {
  $(document).ready(function() {
    $("#filter-cost").css("display", "none");
    $("#filter-cost-widget").slider({
      range: true,
      min: 5,
      max: 500,
      values: [5, 500],
      slide: function(event, ui) {
        return $("#filter-cost").val("$" + ui.values[0] + " - $" + ui.values[1]);
      }
    });
    return $('.filter-control input[type="checkbox"]').button();
  });

}).call(this);
