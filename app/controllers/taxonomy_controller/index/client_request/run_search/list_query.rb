# frozen_string_literal: true

# Class extracted from name controller.
class TaxonomyController::Index::ClientRequest::RunSearch::ListQuery
  def initialize(client_request)
    @client_request = client_request
  end

  def query_string
    TaxonomyController::Index::ClientRequest::Utilities::CoreArgsFilter.new(@client_request, raw_query_string).raw_query_string
                                                                       .sub(/"limit_placeholder"/, @client_request.limit.to_s)
                                                                       .sub(/"offset_placeholder"/, @client_request.offset.to_s)
  end

  def raw_query_string
    s = base_raw_query_string
    s = s.sub(/taxon_comment,/,'') unless @client_request.comments?
    s = s.sub(/taxon_distribution,/,'') unless @client_request.distribution?
    s
  end

  def base_raw_query_string
    <<~HEREDOC
      {
        taxonomy_search(#{TaxonomyController::Index::ClientRequest::Utilities::CoreArgs.new.core_args},
                    limit: "limit_placeholder",
                    offset: "offset_placeholder")
          {
            count,
            taxa
            {
              id,
              is_excluded,
              simple_name,
              full_name,
              full_name_html,
              name_status_name,
              name_status_is_displayed,
              cross_referenced_full_name_id,
              is_pro_parte,
              reference_citation,
              taxon_comment,
              taxon_distribution,
              order_string,
              source_object,
              is_cross_reference,
              cross_reference_to {
                name_id,
                full_name,
                full_name_html,
                is_doubtful,
                is_pro_parte,
                is_misapplication,
                as_misapplication {
                  citing_instance_id,
                  citing_reference_id,
                  citing_reference_author_string_and_year,
                  misapplying_author_string_and_year,
                  name_author_string,
                  cited_simple_name,
                  cited_page,
                  cited_reference_author_string,
                }
              }
              synonyms {
                id,
                name_id,
                simple_name,
                full_name,
                full_name_html,
                name_status,
                is_doubtful,
                is_misapplied,
                is_pro_parte,
                page,
                page_qualifier,
                misapplication_details {
                  name_author_string,
                  cites_simple_name,
                  cites_reference_citation,
                  cites_reference_citation_html,
                  page
                }
              }
            }
          }
      }
    HEREDOC
  end
end

