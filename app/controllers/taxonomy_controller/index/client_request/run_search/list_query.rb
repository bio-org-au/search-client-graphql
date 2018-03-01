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
    s = s.sub(/accepted_taxon_comment,/,'') unless @client_request.comments?
    s = s.sub(/accepted_taxon_distribution,/,'') unless @client_request.distribution?
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
              accepted_taxon_comment,
              accepted_taxon_distribution,
              record_type,
              simple_name,
              full_name,
              full_name_html,
              name_status_name,
              cross_referenced_full_name,
              cross_referenced_full_name_id,
              is_misapplication,
              is_pro_parte,
              reference_citation,
              accepted_taxon_comment,
              accepted_taxon_distribution,
              order_string,
              source_object,
              cross_reference_misapplication_details {
                    citing_instance_id,
                    citing_reference_id,
                    citing_reference_author_string_and_year,
                    misapplying_author_string_and_year,
                    name_author_string,
                    cites_simple_name,
                    cites_page,
                    cites_reference_author_string,
                    pro_parte,
                    is_doubtful
              },
              synonyms {
                id,
                name_id,
                simple_name,
                name_status,
                full_name,
                full_name_html,
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
