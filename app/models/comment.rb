# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  user_name  :string(255)
#  user_email :string(255)
#  body       :text
#  post_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Comment < ActiveRecord::Base
  belongs_to :post

  validates :user_name, :presence => true,
                        :length => { :within => 4..50 },
                        :format => { :with => /[\w\d\s]{4,50}/i }

  validates :user_email, :presence => true,
                         :length => { :within => 8..255 },
                         :format => { :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i }

  validates :body, :presence => true

  validates :post_id, :presence => true,
                      :numericality => { :only_integer => true }
end
