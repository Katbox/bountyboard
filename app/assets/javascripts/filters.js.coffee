initializeFilters = ->
  if $("#dropdown-filters-controls").length > 0

    # global filters object
    filters = []

    # initialize filters controls

    # price filter
    # the price filter uses an exponential scale, since fine dollar-by-dollar
    # control isn't needed in the $10,000 range, but is in the $10 range
    bounty_min_price = parseFloat(
      $("#filter-cost").data("bounty_min_price")
    )
    if bounty_min_price > 0
      bounty_min_price_scaled = Math.log(bounty_min_price)
    else
      bounty_min_price_scaled = 0
    bounty_max_price = parseFloat(
      $("#filter-cost").data("bounty_max_price")
    )
    bounty_max_price_scaled = Math.log(bounty_max_price)

    # updates the price filter display
    # lower and upper bound are the upper and lower bound of the price range
    # selected (both parameters should be in actual dollars and not the
    # exponential scale used by the slider control)
    price_filter_update = (lower_bound, upper_bound) ->
      console.log "Price filter range updated to [$#{lower_bound}, $#{upper_bound}]"
      $("#filter-cost").val("$#{lower_bound} - $#{upper_bound}")
      filters.price = [lower_bound, upper_bound]

    $("#filter-cost-widget").slider
      range: true
      min: bounty_min_price_scaled
      max: bounty_max_price_scaled
      step: 0.01
      values: [bounty_min_price_scaled, bounty_max_price_scaled]
      slide: (event, ui) ->
        # convert from the exponential scale back to dollars
        lower_bound = Math.floor(Math.pow(Math.E, parseFloat(ui.values[0])))
        upper_bound = Math.ceil(Math.pow(Math.E, parseFloat(ui.values[1])))
        price_filter_update(lower_bound, upper_bound)

    # initialize the price display
    price_filter_update(bounty_min_price, bounty_max_price)


    # set up the bounty display
    $("#bounty-list").masonry
      itemSelector: ".bounty-square"
      columnWidth: 100
      gutterWidth: 5
      isAnimated: true
      isFitWidth: true

$(document).ready initializeFilters
$(document).on "page:load", initializeFilters

