require 'spec_helper'

describe PartnerSessionsController do

  describe "GET #new" do
    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #login" do
    context "with valid attributes" do
      it "saves admin id in sessions" do
        partner = FactoryGirl.create(:partner)
        Partner.stub(:find_by_username).and_return(partner)
        post :create, FactoryGirl.attributes_for(:partner)
        session[:partner_id].should == partner.id
      end
      it "redirects to the find member" do
        partner = FactoryGirl.create(:partner)
        Partner.stub(:find_by_username).and_return(partner)
        post :create, FactoryGirl.attributes_for(:partner)
        response.should redirect_to partners_path
      end

    end

    context "with invalid attributes" do
      it "does not save admin id in sessions" do
        partner = FactoryGirl.build(:invalid_partner)
        post :create, FactoryGirl.attributes_for(:invalid_partner)
        session[:partner].should == nil
      end
      it "redirects to the login" do
        partner = FactoryGirl.build(:invalid_partner)
        Partner.stub(:find_by_username).and_return(partner)
        post :create, FactoryGirl.attributes_for(:invalid_partner)
        get :destroy
        response.should redirect_to partner_login_path
      end
      it "re-renders the :new view" do
        partner = FactoryGirl.build(:invalid_partner)
        post :create, FactoryGirl.attributes_for(:invalid_partner)
        response.should render_template :new
      end
    end
  end

  describe "GET #logout" do
    it "destroys sessions" do
      partner = FactoryGirl.create(:partner)
      Partner.stub(:find_by_username).and_return(partner)
      post :create, FactoryGirl.attributes_for(:partner)
      get :destroy
      session[:partner].should == nil
    end
    it "redirect to the login" do
      partner = FactoryGirl.create(:partner)
      Partner.stub(:find_by_username).and_return(partner)
      post :create, FactoryGirl.attributes_for(:partner)
      get :destroy
      response.should redirect_to partner_login_path
    end
  end
end