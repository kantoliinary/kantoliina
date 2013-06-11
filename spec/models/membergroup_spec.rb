# spec/models/contact_spec.rb
require 'spec_helper'

describe Member do
  it "has a valid factory" do
    FactoryGirl.create(:membergroup).should be_valid
  end

  it "is invalid with existing name" do
    FactoryGirl.create(:membergroup)
    FactoryGirl.build(:membergroup).should_not be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:membergroup, name: nil).should_not be_valid
  end

  it "is invalid with text as fee" do
    FactoryGirl.build(:membergroup, fee: "moi").should_not be_valid
  end
end