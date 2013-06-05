#encoding: utf-8

require 'spec_helper'

describe AccountcontrolController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
    partner = FactoryGirl.create(:partner)
    session[:partner_id] = partner.id
  end

  describe "GET #index" do

    context "get :index" do
      it "shows member" do
        member = FactoryGirl.build(:member)
        Member.stub(:find).and_return(member)
        get :index, FactoryGirl.attributes_for(:member)
      end
    end
  end





end