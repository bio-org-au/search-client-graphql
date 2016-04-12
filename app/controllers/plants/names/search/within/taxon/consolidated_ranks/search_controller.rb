class Plants::Names::Search::Within::Taxon::ConsolidatedRanks::SearchController < ApplicationController
  def index
    @name = Name.find(params[:id])
    @ranks = params.keys.collect {|k| "'#{k}'"}.join(',')
    @ranks.sub!(/'unranked'/,"'[unranked]'")
    @ranks.sub!(/'infrafamily'/,"'[infrafamily]'")
    @ranks.sub!(/'infragenus'/,"'[infragenus]'")
    @ranks.sub!(/'infraspecies'/,"'[infraspecies]'")
    @ranks.sub!(/'n\/a'/,"'[n/a]'")
    @ranks.sub!(/'unknown'/,"'[unknown]'")
    @ranks = "(#{@ranks})"
    render action: "index"
  end
end
