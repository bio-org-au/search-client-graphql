# frozen_string_literal: true

# Class extracted from name controller.
class NameController::Show::ClientRequest
  def initialize(show_params)
    @params = show_params
  end

  def id
    @params[:id]
  end
end
