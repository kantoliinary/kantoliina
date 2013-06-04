require "spec_helper"

describe Billing do
  describe "GET #billing" do
    it "sends mail" do
      member = FactoryGirl.build(:member)
      Member.stub(:find).and_return(member)
      FactoryGirl.create(:membergroup)
      lasku = "ddd \n --- \n jee"
      Billing.bill_email(member, lasku).should be_true
    end
  end
end