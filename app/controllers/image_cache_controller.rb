class ImageCacheController < ApplicationController
  def update
    Name.load_image_data
    render text: "updated"
  end
end
