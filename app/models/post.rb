class Post < ApplicationRecord
  belongs_to :user
  # for comments and reply
  acts_as_commentable

end
