class Post < ActiveRecord::Base
  attr_accessible :title, :body, :published, :user_id

  belongs_to :user

  validates :title, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :length => { :within => 1...255 }

  validates :body, :presence => true

  validates :published, :presence => true

  validates :user_id, :presence => true
end
