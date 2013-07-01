initializeFilters = ->
  if $("#dropdown-filters-controls").length > 0

      # wait for update requests from slider controls to subside for
      # at least this many milliseconds before actually updating to
      # prevent sliding the control from generating hundreds of
      # refresh requests
    SLIDER_DELAY = 500

    # parameters passed to the back end for filtering are stored
    # here, indexed by the property being filtered (i.e.
    # filters["price"] = "price_min=30&price_max=60")
    filter_parameters = []
    apply_filters = ->
      sanitized_parameters = []
      for param of filter_parameters
        key = encodeURIComponent(param)
        value = encodeURIComponent(filter_parameters[param])
        sanitized_parameters.push(key + "=" + value)
      Turbolinks.visit(location.pathname + "?" + sanitized_parameters.join("&"))

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
    # the reload parameter is a boolean specifying whether the page
    # should be reloaded with the new filters, defaulting to true
    price_update_timer = null
    price_filter_update = (lower_bound, upper_bound, reload=true) ->
      $("#filter-cost").val("$#{lower_bound} - $#{upper_bound}")

      if reload
        if price_update_timer != null
          clearTimeout price_update_timer
        complete_update = ->
          price_update_timer = null
          filter_parameters["price_min"] = lower_bound
          filter_parameters["price_max"] = upper_bound
          apply_filters()
        price_update_timer = setTimeout complete_update, SLIDER_DELAY

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
    price_filter_update(bounty_min_price, bounty_max_price, false)


    # set up the bounty display
    $("#bounty-list").masonry
      itemSelector: ".bounty-square"
      columnWidth: 100
      gutterWidth: 5
      isAnimated: true
      isFitWidth: true

$(document).ready initializeFilters
$(document).on "page:load", initializeFilters

