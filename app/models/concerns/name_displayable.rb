# frozen_string_literal: true

# Concern for displaying names
# Extracted from name.rb
module NameDisplayable
  extend ActiveSupport::Concern

  def apc_instance_id
    AcceptedName.where(id: id).try("first").try("instance_id")
  end

  def show_status?
    status.show?
  end

  # For compatibility with name_instance_vw.
  def status_name
    status.name
  end

  def author_component_of_full_name
    full_name.sub(/#{Regexp.escape(simple_name)}/, "")
  end
end
