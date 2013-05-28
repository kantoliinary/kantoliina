#encoding: utf-8

require 'spec_helper'


describe MembersController do

  describe "GET #new" do

    context "with not logged in" do
      it "renders not the :new view" do
        get :new
        response.should_not render_template :new
      end

    end
  end


  describe "GET #new" do


    before(:each) do
      admin = FactoryGirl.build(:admin)
      session[:admin] = admin
    end

    it "renders the :new view" do
      get :new
      response.should render_template :new
    end

  end


  describe "GET #index" do


    before(:each) do
      admin = FactoryGirl.build(:admin)
      session[:admin] = admin
    end

    context "get :index" do
      it "shows members" do
        get :index
      end


    end
  end

  describe "POST #create" do


    before(:each) do
      admin = FactoryGirl.build(:admin)

      session[:admin] = admin
    end

    context "with valid attributes" do
      it "saves a member" do
        member = FactoryGirl.build(:member)
        Member.stub(:find).and_return(member)
        post :create, FactoryGirl.attributes_for(:member)
        flash[:member].should_not be_nil
      end
    end
  end


  describe "GET #edit" do

    context "with not logged in" do
      it "renders not the :edit view" do
        member = FactoryGirl.create(:member)
        Member.stub(:find).and_return(member)
        get :edit, FactoryGirl.attributes_for(:member)
      end

    end
  end

  #describe "GET #edit" do
  #
  #  before(:each) do
  #    admin = FactoryGirl.build(:admin)
  #
  #    session[:admin] = admin
  #  end
  #
  #  context "with valid attributes" do
  #    it "loads the correct member" do
  #      member = FactoryGirl.create(:member)
  #      post :edit, FactoryGirl.attributes_for(:member)
  #      @member.should_not be_nil
  #    end
  #  end
  #end

  #

  describe "POST #destroy" do


    before(:each) do
      admin = FactoryGirl.build(:admin)
      session[:admin] = admin
    end

    context "with valid attributes" do
      it "status becomes false" do
        member = FactoryGirl.create(:member)
        Member.stub(:find_by_login).and_return(member)
        delete :destroy, FactoryGirl.attributes_for(:member)
        flash[:notice] == "Jasen poistettu"


      end
    end
  end
end



