class Plants::Names::Search::CultivarController < ApplicationController
  def search
    if params["q"].present?
      @search = Apni::Search::OnName::Cultivar.new(params)
    end
    render action: "index"
  end
end
