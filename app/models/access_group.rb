class AccessGroup < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  def self.all_by_category
    access_groups = {}
    access_groups["groups"] = AccessGroup.where(group_key: ["org","clinical","office"])
    access_groups["categories"] = access_groups["groups"].map{|g| [g.group_key, g.group_title]}.uniq.map{|g| {"key" => g.first, "title" => g.last}}
    access_groups["by_category"] = access_groups["categories"].reduce({}){ |h, (c,i)| h.merge({c["key"] => access_groups["groups"].collect{|g| g if g.group_key == c["key"]}.compact }) }
    access_groups
  end
end
