# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  title      :string(255)     not null
#  body       :text            not null
#  published  :boolean         not null
#  user_id    :integer         not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Post < ActiveRecord::Base
  attr_accessible :title, :body, :published, :user_id

  belongs_to :user

  default_scope order("created_at DESC")

  validates :title, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :length => { :within => 1...255 }

  validates :body, :presence => true

  # NOTE: Don't use :presence => true ! Or else validations will fail
  validates :published, :inclusion => { :in => [true, false] }

  validates :user_id, :presence => true
end
