#encoding: utf-8

# spec/models/contact_spec.rb
require 'spec_helper'

describe Member do
  it "has a valid factory" do
    FactoryGirl.create(:member).should be_valid
  end

  it "is valid without a name" do
    FactoryGirl.build(:member, firstnames: nil).should be_valid
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

  it "is valid with a letter zipcode" do
    FactoryGirl.build(:member, zipcode: "puistola").should be_valid
  end

  it "is valid with right length zipcode" do
    FactoryGirl.build(:member, zipcode: "66666").should be_valid
  end

  it "is invalid without an address" do
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

  it "is invalid without a membergroupid" do
    FactoryGirl.build(:member, membergroup_id: nil).should_not be_valid
  end

  it "is invalid without a membernumber" do
    FactoryGirl.build(:member, membernumber: nil).should_not be_valid
  end

  it "is invalid with letters membernumber" do
    FactoryGirl.build(:member, membernumber: "vaara").should_not be_valid
  end

  it "is unique membernumber" do
    FactoryGirl.create(:member, membernumber: "12345").should be_valid
    FactoryGirl.build(:member, membernumber: "12345").should_not be_valid
  end

  it "is invalid without a mebershipyear" do
    FactoryGirl.build(:member, membershipyear: nil).should_not be_valid
  end

  it "is invalid with wrong length membershipyear" do
    FactoryGirl.build(:member, membershipyear: "123").should_not be_valid
  end

  it "is valid with right length membershipyear" do
    FactoryGirl.build(:member, membershipyear: "1234").should be_valid
  end

  it "is invalid with wrong paymentstatus" do
    FactoryGirl.build(:member, paymentstatus: nil).should_not be_valid
  end

  it "is valid with right paymentstatus" do
    FactoryGirl.build(:member, paymentstatus: true).should be_valid
  end

  it "is valid with right lenderstatus" do
    FactoryGirl.build(:member, lender: true).should be_valid
  end

  it "is invalid with wrong lenderstatus" do
    FactoryGirl.build(:member, lender: nil).should_not be_valid
  end

  it "is valid with right supportstatus" do
    FactoryGirl.build(:member, support: true).should be_valid
  end

  it "is invalid with wrong supportstatus" do
    FactoryGirl.build(:member, support: nil).should_not be_valid
  end

  it "is valid with right country" do
    FactoryGirl.build(:member, country: "Finland").should be_valid
  end

  it "is invalid with nil country" do
    FactoryGirl.build(:member, country: nil).should_not be_valid
  end

  it "generates ref_number" do
    member = FactoryGirl.build(:member, membernumber: "12345")
    Member.generate_refnumber(member.membernumber) == "123453"
  end

  it "generates ref_number" do
    member = FactoryGirl.build(:member, membernumber: nil)
    Member.generate_refnumber(member.membernumber) != "123453"
  end

  it "calls json" do
    member = FactoryGirl.build(:member)
    Member.as_json.should be_true
  end

  it "generates .csv" do
    member = FactoryGirl.create(:member)
    Member.as_csv.should be_true
  end


end
