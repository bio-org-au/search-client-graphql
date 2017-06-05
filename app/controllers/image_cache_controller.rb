# frozen_string_literal: true

# Controller class
class ImageCacheController < ApplicationController
  def update
    Names::Services::Images.load
  end
end
