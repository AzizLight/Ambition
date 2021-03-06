# == Schema Information
#
# Table name: pages
#
#  id         :integer         not null, primary key
#  title      :string(255)     not null
#  body       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  slug       :string(255)
#

class Page < ActiveRecord::Base
  attr_accessible :title, :body

  before_validation :generate_slug

  validates :title, :presence => true,
                    :length => { :within => 1..255 }

  validates :body, :presence => true
  validates :slug, :presence => true,
                   :uniqueness => { :case_sensitive => false },
                   :length => { :maximum => 255 },
                   :format => { :with => /^[a-z0-9-]+/i }

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
