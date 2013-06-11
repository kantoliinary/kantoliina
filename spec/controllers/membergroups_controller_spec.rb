#encoding: utf-8

require 'spec_helper'


describe MembergroupsController do

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
        #Membergroup.stub(:find).and_return(membergroup)
        post :create, :membergroup => {:id => "1", :name => "jäsenryhmä", :fee => "10", :onetimefee => true}
        flash[:notice].should == "Jäsenryhmä lisätty"
      end
    end

    context "with invalid attributes" do
      it "member will be created" do
        post :create
        flash[:notice].should == @membergroup

      end
    end
  end

  describe "GET #index" do

    context "get :index" do
      it "shows membergroups" do
        get :index
        response.should render_template :index
      end
    end
  end

  describe "GET #edit" do

    context "get :edit" do
      it "renders the :edit view" do
        membergroup = FactoryGirl.create(:membergroup)
        get :edit, FactoryGirl.attributes_for(:membergroup)
        response.should render_template :edit
      end

    end



  end

  describe "GET #update" do

    context "with valid attributes" do

      it "update works" do
        membergroup = FactoryGirl.build(:membergroup)
        Membergroup.stub(:find).and_return(membergroup)
        get :update, FactoryGirl.attributes_for(:membergroup)
        flash[:notice].should == "Tiedot muutettu"
      end

      it "redirects to edit_member_path" do
        membergroup = FactoryGirl.build(:membergroup)
        Membergroup.stub(:find).and_return(membergroup)
        get :update, FactoryGirl.attributes_for(:membergroup)
        response.should redirect_to membergroups_path
      end
    end

    context "with invalid attributes" do
      it "update doesn't work" do
        membergroup = FactoryGirl.create(:membergroup)
        get :update,
            :id => membergroup.id,
            :membergroup => {:name => ""}
        response.should redirect_to edit_membergroup_path
      end
    end
  end

  describe "POST #delete" do
    it "deletes a membergroup" do
      membergroup = FactoryGirl.create(:membergroup)
      Membergroup.stub(:find).and_return(membergroup)
      delete :destroy, :id => "1"
      flash[:notice].should == "Jäsenryhmä poistettu"
    end
  end
end

