# frozen_string_literal: true

# Rails model
class Author < ActiveRecord::Base
  self.table_name = "author"
  self.primary_key = "id"
  has_many :names
  has_many :references
end
