class Name < ActiveRecord::Base
  self.table_name = "name"
  self.primary_key = "id"
  acts_as_tree
  belongs_to :rank, class_name: "NameRank", foreign_key: "name_rank_id"
  belongs_to :name_type
  has_many :instances
  has_many :tree_nodes

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
