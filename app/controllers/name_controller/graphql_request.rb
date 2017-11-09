# frozen_string_literal: true

# Class extracted from name controller.
class NameController::GraphqlRequest
  def initialize(form_request)
    @form_request = form_request
  end

  def query
    {
      body: {
        query: query_string
      }
    }
  end

  def query_string
    if @form_request.details?
      DetailQuery.new(@form_request).query_string
    else
      ListQuery.new(@form_request).query_string
    end
  end
end
