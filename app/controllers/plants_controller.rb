# frozen_string_literal: true
class PlantsController < ApplicationController
  private

  def set_zone
    @zone = "plants"
  end
end
