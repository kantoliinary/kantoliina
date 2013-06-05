#encoding: utf-8

require 'spec_helper'

describe SessionsController do

  describe "GET #new" do
    it "renders the :new view" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves admin id in sessions" do
        admin = FactoryGirl.create(:admin)
        Admin.stub(:find_by_username).and_return(admin)
        post :create, FactoryGirl.attributes_for(:admin)
        session[:admin_id].should == admin.id
      end
      it "redirects to the new member" do
        admin = FactoryGirl.create(:admin)
        Admin.stub(:find_by_username).and_return(admin)
        post :create, FactoryGirl.attributes_for(:admin)
        response.should redirect_to members_path
      end

    end

    context "with invalid attributes" do
      it "does not save admin id in sessions" do
        admin = FactoryGirl.build(:invalid_admin)
        post :create, FactoryGirl.attributes_for(:invalid_admin)
        session[:admin].should == nil
      end
      it "re-renders the :loginform view" do
        admin = FactoryGirl.build(:invalid_admin)
        post :create, FactoryGirl.attributes_for(:invalid_admin)
        response.should render_template :new
      end
    end
  end

  describe "GET #destroy" do
    it "destroys sessions" do
      admin = FactoryGirl.create(:admin)
      Admin.stub(:find_by_username).and_return(admin)
      post :create, FactoryGirl.attributes_for(:admin)
      get :destroy
      session[:admin].should == nil
    end
    it "redirect to the login" do
      admin = FactoryGirl.create(:admin)
      Admin.stub(:find_by_username).and_return(admin)
      post :create, FactoryGirl.attributes_for(:admin)
      get :destroy
      response.should redirect_to login_path
    end
  end
end