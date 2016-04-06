class Plants::Names::Within::Taxon::At::RankController < ApplicationController
  def index
    @name = Name.find(params[:id])
    @search = @name.pg_descendants_at_rank(params[:rank].gsub(/DOT/,'.'))
  end
end
