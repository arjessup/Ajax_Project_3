# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  user_id    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :user_id => "Example User",
      :password => "foobar",
      :password_confirmation => "foobar"
      }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a user_id" do
    no_user_id_user = User.new(@attr.merge(:user_id => ""))
    no_user_id_user.should_not be_valid
  end
  
  it "should reject user_ids that are too long" do
    long_user_id = "a" * 501
    long_user_id_user = User.new(@attr.merge(:user_id => long_user_id))
    long_user_id_user.should_not be_valid
  end
  
  it "should reject duplicate user_ids" do
    User.create!(@attr)
    user_with_duplicate_user_id = User.new(@attr)
    user_with_duplicate_user_id.should_not be_valid
  end
  
  it "should reject user_ids identical up to case" do
    upcased_user_id = @attr[:user_id].upcase
    User.create!(@attr.merge(:user_id => upcased_user_id))
    user_with_duplicate_user_id = User.new(@attr)
    user_with_duplicate_user_id.should_not be_valid
  end
  
  describe "password validations" do
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 501
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end # password validations
  
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end # has_password?
    
    describe "authenticate method" do
      it "should return nil on user_id/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:user_id], "wrongpass")
        wrong_password_user.should be_nil
      end
      
      it "should return nil for a user id with no user" do
        nonexistent_user = User.authenticate("invalid id", @attr[:password])
        nonexistent_user.should be_nil
      end
      
      it "should return the user on user id/password match" do
        matching_user = User.authenticate(@attr[:user_id], @attr[:password])
        matching_user.should == @user
      end
    end # authenticate method
  end # password encryption
end
