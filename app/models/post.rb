class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  
  after_save :touch_topic
  
  def touch_topic
    topic.touch
  end
end
