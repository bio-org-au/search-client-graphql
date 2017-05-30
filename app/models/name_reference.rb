# frozen_string_literal: true

# Rails model for a view that joins
#
# Name
# Instance
# Instance Type
# Reference
# Author (of Reference)
#
# The view is the basis for listing the reference citations of each instance
# for the name.
#
# This display has to be strictly sorted by
# - reference year (nulls to the bottom),
# - primary instance before other instances, and
# - author name.
#
# e.g.  order by coalesce(year,9999), primary_instance desc, author_name;
#
# The view is designed to be sorted appropriately.
#
# The view has minimal columns so that it can also be grouped in the required
# way for display.
#
# Example: Diospyros cordifolia Roxb., where the 3 misapplications noted
# in CHAH 2007 should all apear under a single entry for CHAH 2007.
# 
class NameReference < ActiveRecord::Base
  self.table_name = "name_reference_vw"
  belongs_to :name
  belongs_to :reference
  belongs_to :instance_type
  scope :ordered, (lambda do
    order("coalesce(reference_year,9999), primary_instance desc, author_name")
  end)

  def instances
    Instance.where(["name_id = :name_id and reference_id = :reference_id", {name_id: name_id, reference_id: reference_id}])
  end

  def instance_page
    return if instances.size > 1
    instances.first.page
  end

  def formatted_instance_page
    return if instance_page.blank?
    %(: <span class="purple">#{instance_page}</span>)
  end

  # Display entry for an instance.
  # - Reference citation, 
  # - page,
  # - instance type if it is a primary instance
  def entry
    s = [citation_html]
    s.push formatted_instance_page unless formatted_instance_page.blank?
    s.push " [#{primary_instance_type}]" if primary_instance?
    s.join
  end

  # We cannot include instance info in the name_reference_vw because
  # including it prevents the required grouping in the sql.
  #
  # Here we retrieve the instance - we expect the sql to return one
  # instance - the right one.
  def primary_instance_type
    Instance.where(name_id: name.id, reference_id: reference.id)
            .where("cites_id is null and cited_by_id is null")
            .joins(:instance_type)
            .where(instance_type: {primary_instance: true})
            .first
            .instance_type.name
  end

  def standalone?
    instance_standalone
  end

  def primary_instance?
    primary_instance == true
  end

  def distribution?
    instance_note_for_distribution.present?
  end

  def distribution
    instance_note_for_distribution.try("value")
  end

  def comment?
    instance_note_for_comment.present?
  end

  def comment
    instance_note_for_comment.try("value")
  end
end
