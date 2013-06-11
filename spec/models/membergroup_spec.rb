# spec/models/contact_spec.rb
require 'spec_helper'

describe Member do
  it "has a valid factory" do
    FactoryGirl.create(:membergroup).should be_valid
  end

  #it "is invalid without a name" do
  #  FactoryGirl.build(:invalid_name_membergroup).should_not be_valid
  #end
  #
  #it "is invalid with text as fee" do
  #  FactoryGirl.build(:invalid_fee_membergroup).should_not be_valid
  #end
end