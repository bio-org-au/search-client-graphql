class Plants::Names::Search::CommonController < ApplicationController
  def search
    @search = Apni::Search::OnName::Common.new(params)
    render action: "index"
  end
end
