# frozen_string_literal: true

module Plants
  module Names
    module Search
      module Within
        class Taxon
          # Rails class
          class SelectedRanksController < ApplicationController
            def index
              @name = Name.find(params[:id])
              @descendants = Plants::Names::Descendants.new(params[:id])
              render action: "index"
            end
          end
        end
      end
    end
  end
end
