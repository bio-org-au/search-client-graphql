class Plants::Names::Within::GenusController < ApplicationController
  def search
    @search = Apni::Search::OnName::Within::Genus.new(params)
    render action: "index"
  end
end
