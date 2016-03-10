class Plants::Names::Search::AllController < ApplicationController
  def search
    @search = Apni::Search::OnName::TheLot.new(params)
    render action: "index"
  end
end
