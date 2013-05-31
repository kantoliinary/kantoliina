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


  describe Billing do
    describe "GET #billing" do
      it "uses invoice" do
        member = FactoryGirl.build(:member)
        Member.stub(:find).and_return(member)
        member2 = FactoryGirl.build(:member, id: 2)
        Member.stub(:find).and_return(member2)
        FactoryGirl.create(:membergroup)
        Billing.mock("billing")

      end
    end

end
