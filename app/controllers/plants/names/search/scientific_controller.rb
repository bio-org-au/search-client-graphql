class Plants::Names::Search::ScientificController < ApplicationController
  def search
    @search = Apni::Search::OnName::Scientific.new(params)
    render action: "index"
  end
end
