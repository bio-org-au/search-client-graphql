class Name < ActiveRecord::Base
  self.table_name = "name"
  self.primary_key = "id"
  acts_as_tree
  belongs_to :rank, class_name: "NameRank", foreign_key: "name_rank_id"
  belongs_to :name_type
  has_many :instances
  has_many :tree_nodes

  scope :not_a_duplicate, -> { where(duplicate_of_id: nil) }
  scope :with_an_instance, -> { where(["exists (select null from instance where name.id = instance.name_id)"]) }
  scope :lower_full_name_like, ->(string) { where("lower(f_unaccent(full_name)) like lower(f_unaccent(?)) ", string.gsub(/\*/, "%").downcase) }
  scope :lower_simple_name_like, ->(string) { where("lower((simple_name)) like lower((?)) ", string.gsub(/\*/, "%").downcase) }
 
  def instances_in_order
    self.instances.sort do |x,y|
      x.sort_fields <=> y.sort_fields
    end
  end

  def family?
    rank.family?
  end

  def family_name
    n = self
    Name.seek_family_name(n)
  end

  def self.seek_family_name(n)
    if n.blank?
      ""
    elsif n.family?
      n.full_name
    else
      n = n.parent
      Name.seek_family_name(n)
    end
  end

  def apc?
    TreeNode.apc?(full_name)
  end

  def apc_instance_id
    TreeNode.apc(full_name).try('first').try('instance_id')
  end
end
