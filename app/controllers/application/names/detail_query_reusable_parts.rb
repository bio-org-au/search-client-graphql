# frozen_string_literal: true

# This is for reusable parts of name detail query requests
# It provides the core structure for requesting name details which
# is used in a couple of places.
class Application::Names::DetailQueryReusableParts
  def self.name_fields_string
    <<~HEREDOC
      {
        id,
        simple_name,
        full_name,
        full_name_html,
        name_status_name,
        name_status_is_displayed,
        family_name,
          name_usages
          {
            standalone,
            instance_id,
            instance_type_name,
            primary_instance,
            protologue_link,
            reference_details {
              id,
              citation,
              citation_html,
              page,
              page_qualifier,
              year,
              full_citation_with_page,
            },
            misapplication_details {
              direction,
              misapplied_to_full_name,
              misapplied_to_name_id,
              misapplication_type_label,
              misapplied_in_references {
                citation,
                id,
                page,
                page_qualifier,
                display_entry
              },
            }
            synonyms {
              id,
              name_id,
              full_name,
              full_name_html,
              instance_type,
              label,
              page,
              name_status_name,
              misapplied,
              misapplication_citation_details {
                misapplied_in_reference_citation,
                misapplied_in_reference_citation_html,
                misapplied_in_reference_id,
                misapplied_on_page,
                misapplied_on_page_qualifier,
                name_is_repeated,
              }
            }
            accepted_tree_details {
              is_accepted,
              is_excluded,
              comment {
                key,
                value
              },
              distribution {
                key,
                value
              }
            },
            non_current_accepted_tree_details {
              comment {
                key,
                value
              },
              distribution {
                key,
                value
              }
            },
            notes {
              key,
              value
            }
          }
        }
      HEREDOC
  end
end
