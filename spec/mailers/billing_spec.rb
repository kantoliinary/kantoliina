require "spec_helper"

describe Billing do
  describe "GET #billing" do
    it "sends mail" do
      member = FactoryGirl.build(:member)
      Member.stub(:find).and_return(member)
      FactoryGirl.create(:membergroup)
      Billing.bill_email(member).should be_true
    end
  end
end