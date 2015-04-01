class User < GcaSsoClient::User
  has_many :posts
  has_many :topics
end