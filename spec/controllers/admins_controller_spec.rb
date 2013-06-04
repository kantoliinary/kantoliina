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
      it "saves admin id in sessions" do
        admin = FactoryGirl.create(:admin)
        Admin.stub(:find_by_username).and_return(admin)
        post :login, FactoryGirl.attributes_for(:admin)
        session[:admin_id].should == admin.id
      end
      it "redirects to the new member" do
        admin = FactoryGirl.create(:admin)
        Admin.stub(:find_by_username).and_return(admin)
        post :login, FactoryGirl.attributes_for(:admin)
        response.should redirect_to members_path
      end

    end

    context "with invalid attributes" do
      it "does not save admin id in sessions" do
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
    it "destroys sessions" do
      admin = FactoryGirl.create(:admin)
      Admin.stub(:find_by_username).and_return(admin)
      post :login, FactoryGirl.attributes_for(:admin)
      get :logout
      session[:admin].should == nil
    end
    it "redirect to the login" do
      admin = FactoryGirl.create(:admin)
      Admin.stub(:find_by_username).and_return(admin)
      post :login, FactoryGirl.attributes_for(:admin)
      get :logout
      response.should redirect_to login_path
    end
  end
end