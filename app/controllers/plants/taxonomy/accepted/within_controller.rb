# frozen_string_literal: true

# Controller
class Plants::Taxonomy::Accepted::WithinController < ApplicationController
  private

  def set_zone
    @zone = "plants"
  end
end
