require 'spec_helper'

describe AdminsController do

  describe "GET #loginform" do
    it "renders the :loginform view" do
      get :loginform
      response.should render_template :loginform
    end
  end

  describe "POST #login" do
    context "with valid attributes" do
      it "saves admin id in session" do
        admin = FactoryGirl.create(:admin)
        Admin.stub(:find_by_login).and_return(admin)
        post :login, FactoryGirl.attributes_for(:admin)
        session[:admin].should == admin
      end
      it "redirects to the new member" do
        admin = FactoryGirl.create(:admin)
        Admin.stub(:find_by_login).and_return(admin)
        post :login, FactoryGirl.attributes_for(:admin)
        response.should redirect_to new_member_path
      end

    end

    context "with invalid attributes" do
      it "does not save admin id in session" do
        admin = FactoryGirl.build(:invalid_admin)
        post :login, FactoryGirl.attributes_for(:invalid_admin)
        session[:admin].should == nil
      end
      it "re-renders the :loginform view" do
        admin = FactoryGirl.build(:invalid_admin)
        post :login, FactoryGirl.attributes_for(:invalid_admin)
        response.should render_template :loginform
      end
    end
  end

  describe "GET #logout" do
    it "destroys session" do
      admin = FactoryGirl.create(:admin)
      Admin.stub(:find_by_login).and_return(admin)
      post :login, FactoryGirl.attributes_for(:admin)
      get :logout
      session[:admin].should == nil
    end
    it "redirect to the login" do
      admin = FactoryGirl.create(:admin)
      Admin.stub(:find_by_login).and_return(admin)
      post :login, FactoryGirl.attributes_for(:admin)
      get :logout
      response.should redirect_to login_path
    end
  end
end