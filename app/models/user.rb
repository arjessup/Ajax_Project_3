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
  attr_accessor :password
  attr_accessible :user_id, :password, :password_confirmation
  
  validates :user_id, :presence => true,
                      :length => { :maximum => 500 },
                      :uniqueness => { :case_sensitive => false }
  
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..500 }
  
  before_save :encrypt_password
  
  # Return true if the user's password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(user_id, submitted_password)
    user = find_by_user_id(user_id)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  private
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
  
end
