class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy
  
  accepts_nested_attributes_for :posts, reject_if: :all_blank
  
  def last_activity
    (posts.last || self).created_at
  end
end
