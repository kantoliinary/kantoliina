#encoding: utf-8

require 'spec_helper'


describe MembersController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end

  describe "GET #new" do
    context "with not logged in" do
      it "renders not the :new view" do
        session[:admin_id] = nil
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
        FactoryGirl.create(:membergroup)
        post :create, :member => {:id => "1", :firstnames => "joku", :surname => "jokinen", :municipality => "helsinki", :zipcode => "12346",
                                  :address => "puutie", :postoffice => "stadi", :email => "jokin@jotain.com", :membergroup_id => 1, :membernumber => "54321",
                                  :membershipyear => "2014", :paymentstatus => "f", :invoicedate => "08/08/2013", :membership => "t"}
        flash[:notice].should == "Jäsen lisätty"
      end
    end
    context "with invalid attributes" do
      it "member will be created" do
        post :create
        flash[:notice].should == @member

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
        flash[:notice].should == "Tiedot muutettu"
      end

      it "redirects to edit_member_path" do
        member = FactoryGirl.build(:member)
        Member.stub(:find).and_return(member)
        get :update, FactoryGirl.attributes_for(:member)
        response.should redirect_to edit_member_path
      end
    end
    context "with valid attributes" do
      it "update doesn't work" do
        member = FactoryGirl.create(:member)
        get :update,
            :id => member.id,
            :member => {:surname => ""}
        response.should redirect_to edit_member_path
      end
    end
  end

  describe "POST #payment" do
    it "changes paymentstatus" do
      member = FactoryGirl.create(:member)
      Member.stub(:find).and_return(member)
      post :payment, :ids => "{\"ids\":[\"1\"]}"
      flash[:notice].should == "Maksustatus muutettu"
    end
  end

  describe "POST #delete" do
    it "deletes a member" do
      member = FactoryGirl.create(:member)
      Member.stub(:find).and_return(member)
      post :delete, :ids => "{\"ids\":[\"1\"]}"
      flash[:notice].should == "Jäsen poistettu"
    end
  end
end



