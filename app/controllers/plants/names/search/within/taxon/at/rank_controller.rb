class Plants::Names::Search::Within::Taxon::At::RankController < ApplicationController
  def index
    @name = Name.find(params[:id])
    @results = @name.pg_descendants_at_rank(params[:rank].gsub(/DOT/,'.'))
  end
end
