# == Schema Information
#
# Table name: pages
#
#  id         :integer         not null, primary key
#  title      :string(255)     not null
#  body       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Page < ActiveRecord::Base
  attr_accessible :title, :body

  validates :title, :presence => true,
                    :length => { :within => 1..255 }

  validates :body, :presence => true
end
