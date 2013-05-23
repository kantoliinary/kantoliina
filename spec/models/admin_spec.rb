require 'spec_helper'

describe Admin do
  it "has a valid factory" do
    FactoryGirl.create(:admin).should be_valid
  end
  it "is valid with 3 symbol login" do
    FactoryGirl.build(:admin, login: "tes").should be_valid
    end
  it "is valid with 20 symbol login" do
    FactoryGirl.build(:admin, login: "aaaaaaaaaaaaaaaaaaaa").should be_valid
  end
  it "is valid with 8 symbol password" do
    FactoryGirl.build(:admin, password: "aaaaaaaa").should be_valid
  end
  it "is valid with 20 symbol password" do
    FactoryGirl.build(:admin, password: "aaaaaaaaaaaaaaaaaaaa").should be_valid
  end
  it "is invalid without a login" do
    FactoryGirl.build(:admin, login: nil).should_not be_valid
  end
  it "is invalid without a password" do
    FactoryGirl.build(:admin, password: nil).should_not be_valid
  end
  it "is invalid with too short login" do
    FactoryGirl.build(:admin, login: "fd").should_not be_valid
  end
  it "is invalid with too short password" do
    FactoryGirl.build(:admin, password: "aaaaaaa").should_not be_valid
  end
  it "is invalid with too long login" do
    FactoryGirl.build(:admin, login: "aaaaaaaaaaaaaaaaaaaaa").should_not be_valid
  end
  it "is invalid with too long password" do
    FactoryGirl.build(:admin, password: "aaaaaaaaaaaaaaaaaaaaa").should_not be_valid
  end
end