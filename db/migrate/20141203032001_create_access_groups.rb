class CreateAccessGroups < ActiveRecord::Migration
  def change
    create_table :access_groups do |t|
      t.string :key
      t.string :title
      t.string :group_key
      t.string :group_title

      t.timestamps
    end
    
    create_table :access_groups_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :access_group
    end
    
  end
end
