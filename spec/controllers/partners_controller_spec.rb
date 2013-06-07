#encoding: utf-8

require 'spec_helper'

describe PartnersController do

  #
  #describe "require_partner_login" do
  #  context "invalid session" do
  #    it "redirects to partner_login_path" do
  #      partner = FactoryGirl.create(:invalid_partner)
  #      session[:partner_id] = partner.id
  #      admin = FactoryGirl.create(:admin)
  #      session[:admin_id] = admin.id
  #    end
  #  end
  #end

  describe "require_partner_login" do
    context "invalid login" do
      it "does nothing" do
        get :index
        response.should redirect_to partner_login_path
      end
    end

  end

  describe "GET #index" do

    context "valid membernumber" do
      it "shows member" do
        partner = FactoryGirl.create(:partner)
        session[:partner_id] = partner.id
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id


        member = FactoryGirl.create(:member)
        Member.stub(:find).and_return(member)
        post :index, :number => 33333

        flash[:notice].should == "Henkilön jäsenyys on voimassa."
      end
    end
  end

  describe "GET #index" do

    context "invalid membernumber" do
      it "doesn't show" do
        partner = FactoryGirl.create(:partner)
        session[:partner_id] = partner.id
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        member = FactoryGirl.create(:member)
        get :index, :number => "4"
        flash[:notice].should == "Henkilön jäsenyys ei ole voimassa."
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
        response.should redirect_to accountcontrols_path
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
        response.should redirect_to accountcontrols_path
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
        response.should redirect_to accountcontrols_path
      end
    end
    context "invalid password" do
      it "update doesn't work" do
        partner = FactoryGirl.create(:partner)
        session[:partner_id] = partner.id
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => partner.id,
            :admin_password => "qwerty123",
            :partner => {:username => "partner", :password => "qw"}
        response.should redirect_to accountcontrols_path
      end
    end
    context "invalid username" do
      it "update doesn't work" do
        partner = FactoryGirl.create(:partner)
        session[:partner_id] = partner.id
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => partner.id,
            :admin_password => "qwerty123",
            :partner => {:username => "p", :password => ""}
        response.should redirect_to accountcontrols_path
      end
    end
  end

  describe "not loggin in" do
    context "invalid partner" do
      it "login doesn't work" do
      end
    end
  end

end