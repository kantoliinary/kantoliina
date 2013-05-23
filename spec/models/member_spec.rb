# spec/models/contact_spec.rb
require 'spec_helper'

describe Member do
  it "has a valid factory" do
    FactoryGirl.create(:member).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:member, name: nil).should_not be_valid
  end

  it "is invalid without a surname" do
    FactoryGirl.build(:member, surname: nil).should_not be_valid
  end

  it "is invalid without a municipality" do
    FactoryGirl.build(:member, municipality: nil).should_not be_valid
  end

  it "is invalid without a zipcode" do
    FactoryGirl.build(:member, zipcode: nil).should_not be_valid
  end

  it "is invalid with a letter zipcode" do
    FactoryGirl.build(:member, zipcode: "puistola").should_not be_valid
  end


  it "is invalid with wrong lenght zipcode" do
    FactoryGirl.build(:member, zipcode: "6666").should_not be_valid
  end

  it "is valid with right lenght zipcode" do
    FactoryGirl.build(:member, zipcode: "66666").should be_valid
  end

  it "is invalid without a address" do
    FactoryGirl.build(:member, address: nil).should_not be_valid
  end

  it "is invalid without a postoffice" do
    FactoryGirl.build(:member, postoffice: nil).should_not be_valid
  end

  it "is invalid without a email" do
    FactoryGirl.build(:member, email: nil).should_not be_valid
  end

  it "is invalid with @ email" do
    FactoryGirl.build(:member, email: "@").should_not be_valid
  end

  it "is invalid with . email" do
    FactoryGirl.build(:member, email: "jotain@ehka").should_not be_valid
  end

  it "is valid with right form email" do
    FactoryGirl.build(:member, email: "jotain@ehka.com").should be_valid
  end

  it "is invalid without a membergroup" do
    FactoryGirl.build(:member, membergroup: nil).should_not be_valid
  end

  it "is invalid without a membernumber" do
    FactoryGirl.build(:member, membernumber: nil).should_not be_valid
  end

  it "is invalid with letters membernumber" do
    FactoryGirl.build(:member, membernumber: "vaara").should_not be_valid
  end

  it "is invalid without a payday" do
    FactoryGirl.build(:member, payday: nil).should_not be_valid
  end

  it "is invalid with wrong payday" do
    FactoryGirl.build(:member, payday: "maaliskuu").should_not be_valid
  end

  it "is valid with a right form payday" do
    FactoryGirl.build(:member, payday: "27/6/2008").should be_valid
  end


end
