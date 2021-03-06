initializeFilters = ->
  if $("#dropdown-filters-controls").length > 0

    # wait for update requests from slider controls to subside for
    # at least this many milliseconds before actually updating to
    # prevent sliding the control from generating hundreds of
    # refresh requests
    SLIDER_DELAY = 300

    # parameters passed to the back end for filtering are stored
    # here, indexed by the property being filtered (i.e.
    # filter_parameters["price_min"] = 30)
    filter_parameters = []
    apply_filters = ->
      console.log "Applying bounty filters:"
      console.log filter_parameters

      sanitized_parameters = []
      for param of filter_parameters
        key = encodeURIComponent(param)
        value = encodeURIComponent(filter_parameters[param])
        sanitized_parameters.push(key + "=" + value)
      $("#bounty-list").load(
        "/bounties #bounty-list",
        sanitized_parameters.join("&"),
        window.refresh_bounties
      )



    # initialize filters controls

    # price filter

    # The price filter uses an exponential scale, since fine dollar-by-dollar
    # control isn't needed in the $10,000 range, but is in the $10 range. These
    # methods provide conversion routines from dollars to exponential scale and
    # back.
    dollars_to_scale = (dollars) ->
      if dollars > 0
        Math.log(dollars)
      else
        0
    scale_to_dollars = (scale) ->
      Math.pow(Math.E, scale)

    price_filter_attrs = $("#filter-cost").data()
    bounty_min_price = parseFloat(price_filter_attrs.bounty_min_price)
    bounty_min_price_scaled = dollars_to_scale(bounty_min_price)
    bounty_max_price = parseFloat(price_filter_attrs.bounty_max_price)
    bounty_max_price_scaled = dollars_to_scale(bounty_max_price)

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
        # round to whole dollars for a prettier display
        lower_bound = Math.floor(scale_to_dollars(ui.values[0]))
        upper_bound = Math.ceil(scale_to_dollars(ui.values[1]))
        price_filter_update(lower_bound, upper_bound)

    # initialize the price display
    price_filter_update(bounty_min_price, bounty_max_price, false)


    # adult content filter

    $("#filter-adult").buttonset()
    $("#filter-adult").change ->
      filter_parameters["adult"] = $("#filter-adult :checked").val()
      apply_filters()


    # bounties you own

    $("#filter-ownership").buttonset()
    $("#filter-ownership").change ->
      ownership_value = $("#filter-ownership :checked").val()
      if ownership_value is ""
        delete filter_parameters["own"]
      else
        filter_parameters["own"] = ownership_value
      apply_filters()


    # bounties you may complete

    $("#filter-candidacy").buttonset()
    status_filter = $("#filter-status")
    ownership_filter = $("#filter-ownership")
    last_status_value = status_filter.find(":checked").val()
    last_ownership_value = ownership_filter.find(":checked").val()
    $("#filter-candidacy").change ->
      may_accept_value = $("#filter-candidacy :checked").val()
      if may_accept_value is ""
        delete filter_parameters["may_accept"]

        # reenable the status filter
        if last_status_value isnt ""
          filter_parameters["status"] = last_status_value
        status_filter.find("input").button( disabled: false )
        status_filter.find(
          "input[value='#{last_status_value}']"
        ).prop("checked", true)
        status_filter.buttonset("refresh")

        # reenable the ownership filter
        if last_ownership_value isnt ""
          filter_parameters["own"] = last_ownership_value
        ownership_filter.find("input").button( disabled: false )
        ownership_filter.find(
          "input[value='#{last_ownership_value}']"
        ).prop("checked", true)
        ownership_filter.buttonset("refresh")

        apply_filters()
      else
        filter_parameters["may_accept"] = may_accept_value

        # disable the status filter
        delete filter_parameters["status"]
        last_status_value = status_filter.find(":checked").val()
        status_filter.find("input[value='unclaimed']").prop("checked", true)
        status_filter.find("input").button( disabled: true )
        status_filter.buttonset("refresh")

        # disable the ownership filter
        delete filter_parameters["own"]
        last_ownership_value = ownership_filter.find(":checked").val()
        ownership_filter.find("input[value='']").prop("checked", true)
        ownership_filter.find("input").button( disabled: true )
        ownership_filter.buttonset("refresh")

        apply_filters()


    # status filter

    $("#filter-status").buttonset()
    $("#filter-status").change ->
      allowed_status = $("#filter-status :checked").val()
      if allowed_status is ""
        delete filter_parameters["status"]
      else
        filter_parameters["status"] = allowed_status
      apply_filters()


$(document).ready initializeFilters
$(document).on "page:load", initializeFilters

