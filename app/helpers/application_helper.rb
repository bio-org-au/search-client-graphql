# frozen_string_literal: true

# General view helpers.
module ApplicationHelper
  def env_tag
    case Rails.configuration.try('environment')
    when /^dev/i then 'Dev'
    when /^test/i then 'Test'
    when /^stag/i then 'Stage'
    when /^prod/i then ''
    else
      'Unknown'
    end
  end

  def development?
    Rails.configuration.try('environment').match(/^development/i)
  end

  def rank_options
    [1, 2, 3, 4]
  end

  def scientific_autonym_field_value
    san = if params['search'] == 'Search' || params['count'] == 'Count'
            params['scientific_autonym_name']
          else
            '1'
          end
    san
  end

  def scientific_named_hybrid_name_field_value
    san = if params['search'] == 'Search' || params['count'] == 'Count'
            params['scientific_named_hybrid_name']
          else
            '1'
          end
    san
  end

  def scientific_hybrid_formula_name_field_value
    san = if params['search'] == 'Search'
            params['scientific_hybrid_formula_name']
          else
            '1'
          end
    san
  end

  def scientific_name_field_value
    san = if params['search'] == 'Search' || params['count'] == 'Count'
            params['scientific_name']
          else
            '1'
          end
    san
  end

  def type_note_key_type_field_value
    san = if params['search'] == 'Search' || params['count'] == 'Count'
            params['type_note_key_type']
          else
            '1'
          end
    san
  end

  def type_note_key_lectotype_field_value
    san = if params['search'] == 'Search' || params['count'] == 'Count'
            params['type_note_key_lectotype']
          else
            '1'
          end
    san
  end

  def type_note_key_neotype_field_value
    san = if params['search'] == 'Search' || params['count'] == 'Count'
            params['type_note_key_neotype']
          else
            '1'
          end
    san
  end

  def advanced_search_name_hover_text
    'Enter a name, or part of a name to restrict the search.
Wildcards are supported.'
  end

  def no_search_done_message
    'No search done.  Please enter something in at least one search field.'
  end

  def protologue_hover_text
    'When checked, citations must match the protologue reference.'
  end

  def scientific_named_hybrid_name_hover_text
    'When checked, scientific named hybrid names will be searched.'
  end

  def scientific_hybrid_formula_name_hover_text
    'When checked, scientific hybrid formula names will be searched.'
  end

  def scientific_autonym_hover_text
    'When checked, scientific autonym names will be included in the search.'
  end

  def scientific_name_hover_text
    "When checked, scientific names that are not autonyms or hybrids will \
be searched."
  end

  def type_note_key_type_hover_text
    'When checked, this field looks for the type note text in a type note.'
  end

  def type_note_key_neotype_hover_text
    'When checked, this field looks for the type note text in a neotype note.'
  end

  def type_note_key_lectotype_hover_text
    'When checked, this field looks for the type note text in a lectotype note.'
  end

  def cultivar_name_hover_text
    'When checked, cultivar names will be included in the search.'
  end

  def common_name_hover_text
    'When checked, common names will be included in the search.'
  end

  def include_ranks_below_hover_text
    'When checked, the search will also include ranks below the selected rank.'
  end

  def show_family_hover_text
    "When checked, each taxon's family name will be displayed in the results."
  end

  def show_links_hover_text
    'When checked, taxon names will be hyperlinked.'
  end

  def show_details_hover_text
    "When checked, biblographic and synonymy details for each taxon will be \
displayed in the search results.  This can slow down the results."
  end

  def clear_form_link_hover_text(type_of_search = '')
    "Clear any search and start a new #{type_of_search} search."
  end

  def taxonomy_link_hover_text
    'Go to taxonomy search.'
  end

  def name_check_link_hover_text
    'Go to name check.'
  end
end
