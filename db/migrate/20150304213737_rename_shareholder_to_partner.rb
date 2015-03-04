class RenameShareholderToPartner < ActiveRecord::Migration
  def self.up
    AccessGroup.where(key: "shareholder").first.update_attributes(key: "partner", title: "Partner")
  end
  
  def self.down
    AccessGroup.where(key: "partner").first.update_attributes(key: "shareholder", title: "Shareholder")
  end
end
