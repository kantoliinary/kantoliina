require 'spec_helper'

describe Admin do
  it "has a valid factory" do
    FactoryGirl.create(:admin).should be_valid
  end
  it "is valid with 3 symbol username" do
    FactoryGirl.build(:admin, username: "tes").should be_valid
    end
  it "is valid with 20 symbol username" do
    FactoryGirl.build(:admin, username: "aaaaaaaaaaaaaaaaaaaa").should be_valid
  end
  it "is valid with 8 symbol password" do
    FactoryGirl.build(:admin, password: "aaaaaaaa").should be_valid
  end
  it "is valid with 20 symbol password" do
    FactoryGirl.build(:admin, password: "aaaaaaaaaaaaaaaaaaaa").should be_valid
  end
  it "is invalid without a username" do
    FactoryGirl.build(:admin, username: nil).should_not be_valid
  end
  it "is invalid without a password" do
    FactoryGirl.build(:admin, password: nil).should_not be_valid
  end
  it "is invalid with too short username" do
    FactoryGirl.build(:admin, username: "fd").should_not be_valid
  end
  it "is invalid with too short password" do
    FactoryGirl.build(:admin, password: "aaaaaaa").should_not be_valid
  end
  it "is invalid with too long username" do
    FactoryGirl.build(:admin, username: "aaaaaaaaaaaaaaaaaaaaa").should_not be_valid
  end
  it "is invalid with too long password" do
    FactoryGirl.build(:admin, password: "aaaaaaaaaaaaaaaaaaaaa").should_not be_valid
  end
end