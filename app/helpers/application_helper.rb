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
    [1,2,3,4]
  end

  def scientific_autonym_field_value
    if params['search'] == 'Search' || params['count'] == 'Count'
      san = params['scientific_autonym_name']
    else
      san = '1'
    end
    san
  end

  def scientific_hybrid_name_field_value
    if params['search'] == 'Search' || params['count'] == 'Count'
      san = params['scientific_hybrid_name']
    else
      san = '1'
    end
    san
  end

  def scientific_name_field_value
    if params['search'] == 'Search' || params['count'] == 'Count'
      san = params['scientific_name']
    else
      san = '1'
    end
    san
  end

  def type_note_key_type_field_value
    if params['search'] == 'Search' || params['count'] == 'Count'
      san = params['type_note_key_type']
    else
      san = '1'
    end
    san
  end

  def type_note_key_lectotype_field_value
    if params['search'] == 'Search' || params['count'] == 'Count'
      san = params['type_note_key_lectotype']
    else
      san = '1'
    end
    san
  end

  def type_note_key_neotype_field_value
    if params['search'] == 'Search' || params['count'] == 'Count'
      san = params['type_note_key_neotype']
    else
      san = '1'
    end
    san
  end
end
