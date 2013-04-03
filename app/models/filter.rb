class Filter
  
  attr_accessor :template

  # The Filter class combines a FilterTemplate with concrete values to create a
  # complete filter for bounties being displayed to the user.

  # session is the current session object
  # templateID is the id of the FilterTemplate this filter should use
  # values is an array of values to be used for filtering and should match the
  #   number of parameters taken by the FilterTemplate's sql string
  def initialize(session, templateID, values)

    @template = FilterTemplate.find(templateID)
    if not @template?
      raise "No FilterTemplate with ID \"#{templateID}\" could be found."
      
    @session = session
    @session[:filters]
    @values = values
  end

  # apply this filter to the passed query and return the new query object
  def filter(query)
    query.where(@template.sql, values)
  end


  # custom getter and setter for the values property uses the session cookie
  # for storage

  def values
    @session[:filters][@template.id] 
  end

  def values=(newValues)
    @session[:filters][@template.id] = newValues
  end
end

