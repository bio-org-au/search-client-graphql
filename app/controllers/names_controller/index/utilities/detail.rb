# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::Utilities::Detail

  def initialize(client_request)
    @client_request = client_request
  end

  def data_structure
    str = +'{ paginatorInfo { count currentPage hasMorePages firstItem lastItem lastPage perPage, total }, '
    str << ' data '
    str << Application::Names::DetailQueryReusableParts.new(@client_request).name_fields_string
    str << '}'
    str
  end
end
