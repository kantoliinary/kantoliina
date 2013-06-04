require 'spec_helper'

describe Partner do
  it "has a valid factory" do
    FactoryGirl.create(:partner).should be_valid
  end
  it "is valid with 3 symbol username" do
    FactoryGirl.build(:partner, username: "tes").should be_valid
  end
  it "is valid with 20 symbol username" do
    FactoryGirl.build(:partner, username: "aaaaaaaaaaaaaaaaaaaa").should be_valid
  end
  it "is valid with 8 symbol password" do
    FactoryGirl.build(:partner, password: "aaaaaaaa").should be_valid
  end
  it "is valid with 20 symbol password" do
    FactoryGirl.build(:partner, password: "aaaaaaaaaaaaaaaaaaaa").should be_valid
  end
  it "is invalid without a username" do
    FactoryGirl.build(:partner, username: nil).should_not be_valid
  end
  it "is invalid without a password" do
    FactoryGirl.build(:partner, password: nil).should_not be_valid
  end
  it "is invalid with too short username" do
    FactoryGirl.build(:partner, username: "fd").should_not be_valid
  end
  it "is invalid with too short password" do
    FactoryGirl.build(:partner, password: "aaaaaaa").should_not be_valid
  end
  it "is invalid with too long username" do
    FactoryGirl.build(:partner, username: "aaaaaaaaaaaaaaaaaaaaa").should_not be_valid
  end
  it "is invalid with too long password" do
    FactoryGirl.build(:partner, password: "aaaaaaaaaaaaaaaaaaaaa").should_not be_valid
  end
end
