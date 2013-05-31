#encoding: utf-8

require 'spec_helper'


describe MembersController do

  before(:each) do
    admin = FactoryGirl.build(:admin)
    session[:admin] = admin
  end

  describe "GET #new" do
    context "with not logged in" do
      it "renders not the :new view" do
        session[:admin] = nil
        get :new
        response.should_not render_template :new
      end

    end

    context "with logged in" do
      it "renders the :new view" do
        get :new
        response.should render_template :new
      end
    end
  end


  describe "POST #create" do

    context "with valid attributes" do
      it "member will be created" do
        member = FactoryGirl.build(:member)
        post :create, FactoryGirl.attributes_for(:member)
        flash[:notice] == "Jäsen lisätty!"
      end
    end
  end


  describe "#invoice" do


  end


  describe "POST #destroy" do
    context "with valid attributes" do
      it "member shall be removed" do
        member = FactoryGirl.build(:member)
        Member.stub(:find).and_return(member)
        delete :destroy, FactoryGirl.attributes_for(:member)
        flash[:notice] == "Jasen poistettu"
      end
    end
  end


  describe "GET #index" do

    context "get :index" do
      it "shows members" do
        get :index
        response.should render_template :index
      end
    end
  end

  describe "GET #edit" do

    context "get :edit" do
      it "renders the :edit view" do
        member = FactoryGirl.create(:member)
        get :edit, FactoryGirl.attributes_for(:member)
        response.should render_template :edit
      end
    end

  end

  describe "GET #update" do

    context "with valid attributes" do

      it "update works" do
        member = FactoryGirl.build(:member)
        Member.stub(:find).and_return(member)
        get :update, FactoryGirl.attributes_for(:member)
        flash[:notice].should == "Tiedot muutettu!"
      end

      it "redirects to edit_member_path" do
        member = FactoryGirl.build(:member)
        Member.stub(:find).and_return(member)
        get :update, FactoryGirl.attributes_for(:member)
        response.should redirect_to edit_member_path
      end
    end
  end

  describe "GET #send_invoices" do

  end

  describe "GET #search_with_filter" do


  end
end


