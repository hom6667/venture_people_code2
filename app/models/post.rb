class Post < ApplicationRecord
  resourcify
  acts_as_votable

  belongs_to :user
  # for comments and reply
  acts_as_commentable

end
