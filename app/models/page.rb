class Page < ActiveRecord::Base
  attr_accessible :title, :body

  validates :title, :presence => true,
                    :length => { :within => 1..255 }

  validates :body, :presence => true
end
