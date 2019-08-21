# frozen_string_literal: true

# Class extracted from name controller.
class NamesController::Index::Utilities::List
  def data_structure
    str = +'{count,names{id,full_name,name_status_name,'
    str << 'name_status_is_displayed,family_name}}'
    str
  end
end
