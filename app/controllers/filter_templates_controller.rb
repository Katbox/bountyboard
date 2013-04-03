class FilterTemplatesController < ApplicationController

  def index
    @filterTemplates = FilterTemplate.all()
  end

  def show
    @filterTemplate = FilterTemplate.find(params[:id])
  end

end

