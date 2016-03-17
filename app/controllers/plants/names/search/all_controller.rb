class Plants::Names::Search::AllController < ApplicationController
  def index
    if params["q"].present?
      @search = Apni::Search::OnName::TheLot.new(params)
    end
    render action: "index"
  end
end
