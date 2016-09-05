# frozen_string_literal: true

# Rails model
class ShardConfig < ActiveRecord::Base
  self.table_name = "shard_config"
  self.primary_key = "id"

  def self.tree_label
    find_by(name: "tree label").value
  rescue
    "tree label"
  end

  def self.name_label
    find_by(name: "name label").value
  rescue
    "name label"
  end

  def self.banner_text
    find_by(name: "banner text").value
  rescue
    "banner text"
  end

  def self.menu_label
    find_by(name: "menu label").value
  rescue
    "menu label"
  end

  def self.description_html
    find_by(name: "description html").value
  rescue
    "description html"
  end

  def self.tree_description_html
    find_by(name: "tree description html").value
  rescue
    "tree description html"
  end

  def self.tree_label_text
    find_by(name: "tree label text").value
  rescue
    "tree label text"
  end

  def self.tree_banner_text
    find_by(name: "tree banner text").value
  rescue
    "description html"
  end

  def self.page_title
    find_by(name: "page title").value
  rescue
    "page title"
  end

  def self.name_description_html
    find_by(name: "name description html").value
  rescue
    "name description html"
  end

  def self.tree_search_help_text_html
    find_by(name: "tree search help text html").value
  rescue
    "tree search help text html"
  end

  def self.name_search_help_text_html
    find_by(name: "name search help text html").value
  rescue
    "name search help text html"
  end

  def self.services_path_name_element
    find_by(name: "services path name element").value
  rescue
    "services path name element"
  end

  def self.services_path_tree_element
    find_by(name: "services path tree element").value
  rescue
    "services path tree element"
  end
end
