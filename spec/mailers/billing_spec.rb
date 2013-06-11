require "spec_helper"

describe Billing do
  describe "GET #billing" do
    it "sends invoice" do
      member = FactoryGirl.build(:member)
      Member.stub(:find).and_return(member)
      FactoryGirl.create(:membergroup)
      lasku = "ddd \n --- \n jee"
      Billing.bill_email(member, lasku).should be_true
    end
    it "sends mail" do
      member = FactoryGirl.build(:member)
      Member.stub(:find).and_return(member)
      viesti = "joo"
      otsikko = "topic"
      Billing.send_email(member, viesti, otsikko).should be_true
    end
  end
end