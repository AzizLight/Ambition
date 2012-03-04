class User < ActiveRecord::Base
  authenticates_with_sorcery!

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
