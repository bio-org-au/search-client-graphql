class ImageCacheController < ApplicationController
  def update
    Names::Services::Images.load
  end
end
