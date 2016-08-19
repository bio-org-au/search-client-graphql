# frozen_string_literal: true
class AcceptedName < ActiveRecord::Base
  self.table_name = "accepted_name_vw"
  self.primary_key = "id"
  APC_ACCEPTED = "ApcConcept"
  APC_EXCLUDED = "ApcExcluded"
  belongs_to :status, class_name: "NameStatus", foreign_key: "name_status_id"
  belongs_to :rank, class_name: "NameRank", foreign_key: "name_rank_id"
  belongs_to :reference
  belongs_to :instance
  belongs_to :name, foreign_key: :id
  has_one :apc_comment, through: :instance
  has_many :synonyms, through: :instance
  has_many :names, through: :synonyms
  has_many :instance_types, through: :synonyms
  has_many :instance_notes, through: :instance
  has_many :instance_note_keys, through: :instance_notes
  has_many :cites, through: :synonyms
  has_many :cite_references, through: :synonyms, source: :reference
  scope :simple_name_like, ->(string) { where("lower(simple_name) like lower(?) ", string.tr("*", "%").downcase) }
  scope :full_name_like, ->(string) { where("lower(full_name) like lower(?) ", string.tr("*", "%").downcase) }
  scope :ordered, -> { order("sort_name") }
  scope :accepted, -> { where(type_code: APC_ACCEPTED) }
  scope :excluded, -> { where(type_code: APC_EXCLUDED) }

  def show_status?
    status.show?
  end

  def accepted_accepted?
    type_code == APC_ACCEPTED
  end

  def accepted_excluded?
    type_code == APC_EXCLUDED
  end

  def to_csv
    attributes.values_at(*Name.columns.map(&:name))
    [full_name, status.name].to_csv
  end
end
