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
    @attr = { :user_id => "Example User" }
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
end
