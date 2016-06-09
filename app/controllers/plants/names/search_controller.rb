class Plants::Names::SearchController < ApplicationController
  def index
    logger.debug(" Plants::Names::SearchController < ApplicationController")
    set_zone
    if params["q"].present?
      search
    end
    respond_to do |format|
      format.html
      format.json
      format.csv { render :index }
    end
  end

  private

  def search
    case params[:search_type]
    when /scientific-and-cultivar\z/
      @search = Plants::Names::Search::ScientificAndCultivar.new(params)
    when /cultivar\z/
      @search = Plants::Names::Search::Cultivar.new(params)
    when /common\z/
      @search = Plants::Names::Search::Common.new(params)
    else
      @search = Plants::Names::Search::Scientific.new(params)
    end
  end

  def set_zone
    @zone = "plants"
  end
end
