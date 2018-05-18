# frozen_string_literal: true

# Class extracted from name controller.
class Application::Show::ClientRequest
  def initialize(show_params)
    throw 'not used client request'
    @params = show_params
  end

  def id
    @params[:id]
  end
end
