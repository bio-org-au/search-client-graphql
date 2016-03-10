class Plants::Names::Search::CultivarController < ApplicationController
  def search
    @search = Apni::Search::OnName::Cultivar.new(params)
    render action: "index"
  end
end
