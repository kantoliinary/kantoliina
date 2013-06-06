#encoding: utf-8

require 'spec_helper'

describe PartnersController do

  before(:each) do
    partner = FactoryGirl.create(:partner)
    session[:partner_id] = partner.id
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end


  describe "GET #index" do

    context "get :index" do
      it "shows member" do
        member = FactoryGirl.build(:member)
        Member.stub(:find).and_return(member)
        get :index, FactoryGirl.attributes_for(:member)
        flash[:notice] == "Henkilön jäsenyys on voimassa."
      end
    end
  end

  describe "PUT #update" do

    context "with valid attributes" do

      it "update works" do
        partner = FactoryGirl.create(:partner)
        session[:partner_id] = partner.id
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => partner.id,
            :admin_password => "qwerty123",
            :partner => {:username => "partner", :password => "qwerty123"}
        response.should redirect_to accountcontrol_index_path
      end
    end
    context "with empty password" do
      it "update works for username" do
        partner = FactoryGirl.create(:partner)
        session[:partner_id] = partner.id
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => partner.id,
            :admin_password => "qwerty123",
            :partner => {:username => "partner", :password => ""}
        response.should redirect_to accountcontrol_index_path
      end
    end
    context "invalid admin" do
      it "update doesn't work" do
        partner = FactoryGirl.create(:partner)
        session[:partner_id] = partner.id
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => partner.id,
            :admin_password => "qwertyz",
            :partner => {:username => "partner", :password => ""}
        response.should redirect_to accountcontrol_index_path
      end
    end

    context "with all empty" do
      it "empty values" do
        partner = FactoryGirl.create(:partner)
        session[:partner_id] = partner.id
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => partner.id,
            :admin_password => "qwerty123",
            :partner => {:username => "", :passw
        ord => ""}
        response.should redirect_to accountcontrol_index_path
      end
    end
  end

end