class Plants::Names::Search::ScientificController < ApplicationController
  def search
    if params["q"].present?
      @search = Apni::Search::OnName::Scientific.new(params)
    end
    render action: "index"
  end
end
