# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Show::GraphqlQuery
  def initialize(client_request)
    @client_request = client_request
  end

  def as_string
    raw_query_string.delete(' ')
                    .delete("\n")
      .sub(/id_placeholder/, @client_request.id.to_i.to_s)
  end

  private

  def raw_query_string
    <<~HEREDOC
      {
        name(id: id_placeholder)
        #{Application::Names::DetailQueryReusableParts.name_fields_string}
        }
    HEREDOC
  end
end
