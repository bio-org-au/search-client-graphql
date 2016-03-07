class ApniController < ApplicationController
  def index
  end

  def search
    @search = Apni::Search::Base.new(params)
    render action: 'index'
  end

  def about
  end
end
