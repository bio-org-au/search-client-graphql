# frozen_string_literal: true

# Controller
class ToggleWildcardController < ApplicationController
  def update
    if request.post?
      session[:add_trailing_wildcard] = !session[:add_trailing_wildcard]
    end
  end
end
