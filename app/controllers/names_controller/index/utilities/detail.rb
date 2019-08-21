# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::Utilities::Detail

  def initialize(client_request)
    @client_request = client_request
  end

  def data_structure
    <<~HEREDOC
        {
          count,
          names
          #{Application::Names::DetailQueryReusableParts.new(@client_request).name_fields_string}
        }
    HEREDOC
  end

end
