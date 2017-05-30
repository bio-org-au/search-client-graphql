# frozen_string_literal: true

# Controller
class NamesController < ApplicationController
  def xshow
    @name = Name.find_by(id: params[:id])
    @name_details = NameDetail.ordered.where(id: params[:id])
    @target_id = params[:target_id]
  end

  def show2
    @name = Name.find_by(id: params[:id])
    @name_details = NameReference.ordered
                                 .select("name_id, reference_id, instance_type_id, author_id, citation_html, reference_year, author_name, primary_instance")
                                 .where(name_id: params[:id]).group("name_id, reference_id, instance_type_id, author_id, citation_html, reference_year, author_name, primary_instance")
    @target_id = params[:target_id]
    render "show_old"
  end

  def show3
    @name = Name.find_by(id: params[:id])
    @name_references = NameReference.ordered
                                    .select("name_id, reference_id, instance_type_id, author_id, citation_html, reference_year, author_name, primary_instance")
                                    .where(name_id: params[:id]).group("name_id, reference_id, instance_type_id, author_id, citation_html, reference_year, author_name, primary_instance")
    @name_reference_instance_set = NameReferenceInstanceSet.new(@name_references).results
    @target_id = params[:target_id]
  end

  def show
    @name = Name.find_by(id: params[:id])
    @name_reference_instance_set = NameReferenceInstanceSet2.new(params[:id]).results
    @target_id = params[:target_id]
    render :show2
  end

  def raw
    @name = Name.find_by(id: params[:id])
    @name_reference_instance_set = NameReferenceInstanceSet2.new(params[:id]).results
    @target_id = params[:target_id]
    render :raw, layout: false
  end
end
