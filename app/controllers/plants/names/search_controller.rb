class Plants::Names::SearchController < ApplicationController
  def search
    @search = Apni::Search::OnName::Simple.new(params)
    render action: "index"
  end
end
