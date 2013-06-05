#encoding: utf-8

require 'spec_helper'

describe InvoiceController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end


  describe "POST #create" do

    context "with valid attributes" do
      it "mail will be created" do
        FactoryGirl.create(:membergroup)
        member = FactoryGirl.create(:member)
        Member.stub(:find).and_return(member)
        post :create, FactoryGirl.attributes_for(:member)
        response.should redirect_to members_path
      end
    end
  end
end