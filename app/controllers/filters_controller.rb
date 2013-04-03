class FiltersController < ApplicationController

  def create
    @newFilter = new Filter(session, params[:templateID], params[:values])
  end

  def update
	Filter_find(params[:templateID])
  end

  def destroy
	Filter_destroy(params[:templateID])
  end

  # Since Filter models are stored in session cookies instead of the database,
  # they aren't ActiveRecord models and don't have standard ActiveRecord
  # getters like all() and find(), so equivalent methods have to be defined
  # here. Note that the more elegant solution of defining all() and find()
  # methods directly in the Filter class won't work because they need access to
  # the session object, which models don't have.

  # returns all of this user's active filters, as an array of Filter objects
  # indexed by their filter template ID
  def Filter_all()
	
	# the filter list is cached to avoid rebuilding a list of Filter objects on
	# every call to this method
	return @allFilters if defined?(@allFilters) and not @allFilters.nil?

	@allFilters = []
	if session.has_key?(:filters)
		session[:filters].each do |templateID|
		  @allFilters[templateID] = Filter.new(session, templateID, session[:filters][templateID])
		end
	end
	@allFilters
  end

  # takes a filter template ID and returns the corresponding Filter object or
  # nil if this user doesn't have a filter corresponding to that template
  def Filter_find(filterTemplateID)
	Filter_all()[filterTemplateID]
  end

  def Filter_destroy(filterTemplateID)
	deletedFilter = session[:filters].delete(filterTemplateID)

	# if a filter was deleted and the filter list has been cached, remove the
	# filter from the cache too
	if not deletedFilter.nil? and defined?(@allFilters)
	  @allFilters.delete_at(filterTemplateID)
  end

end

