# == Schema Information
#
# Table name: users
#
#  id                              :integer         not null, primary key
#  username                        :string(255)     not null
#  email                           :string(255)
#  crypted_password                :string(255)
#  salt                            :string(255)
#  created_at                      :datetime        not null
#  updated_at                      :datetime        not null
#  remember_me_token               :string(255)
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string(255)
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :posts

  attr_accessible :username, :email, :password, :password_confirmation

  validates :username, :presence => true,
                       :uniqueness => { :case_sensitive => false },
                       :length => { :within => 2...42 },
                       :format => { :with => /^\w{2,}$/i }

  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :length => { :within => 5...255 },
                    :format => { :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i }

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 4...255 }

  validates :password_confirmation, :presence => true
end
