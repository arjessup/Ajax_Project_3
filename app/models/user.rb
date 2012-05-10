# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  user_id    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :user_id
  
  validates :user_id, :presence => true,
                      :length => { :maximum => 500 },
                      :uniqueness => { :case_sensitive => false }
end
