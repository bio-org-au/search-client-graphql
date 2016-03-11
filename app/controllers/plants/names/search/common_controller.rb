class Plants::Names::Search::CommonController < ApplicationController
  def search
    if params["q"].present?
      @search = Apni::Search::OnName::Common.new(params)
    end
    render action: "index"
  end
end
