# == Schema Information
#
# Table name: activity_logs
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  entity      :string(255)
#  user_id     :integer
#  ip_address  :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class ActivityLog < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :description, :entity, :user_id, :ip_address

  validates :name, :presence => true,
                   :length => { :within => 5..50 }

  validates :description, :presence => true,
                          :length => { :within => 10..255 }

  validates :entity, :presence => true,
                     :length => { :within => 4..10 }

  validates :user_id, :presence => true,
                      :numericality => { :only_integer => true, :greater_than => 0 }

  # NOTE: Only IPv4 are supported right now.
  validates :ip_address, :presence => true,
                         :length => { :within => 7..15 },
                         :format => { :with => /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/ }
end
