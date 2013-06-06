#encoding: utf-8

require 'spec_helper'

describe AdminsController do

  describe "PUT #update" do

    context "with valid attributes" do
      it "update works" do
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => admin.id,
            :old_password => "qwerty123",
            :admin => {:username => "admin", :password => "qwerty1223"}
        response.should redirect_to accountcontrols_path
      end
    end
    context "with empty password" do
      it "update works for username" do
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => admin.id,
            :old_password => "qwerty123",
            :admin => {:username => "admin", :password => ""}
        response.should redirect_to accountcontrols_path
      end
    end
    context "with invalid password" do
      it "update doesn't work" do
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => admin.id,
            :old_password => "qwerty123",
            :admin => {:username => "admin", :password => "a"}
        response.should redirect_to accountcontrols_path
      end
    end
    context "with invalid username" do
      it "update doesn't work" do
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => admin.id,
            :old_password => "qwerty123",
            :admin => {:username => "", :password => ""}
        response.should redirect_to accountcontrols_path
      end
    end
    context "invalid admin" do
      it "update doesn't work" do
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        put :update,
            :id => admin.id,
            :old_password => "qwerty13",
            :admin => {:username => "admin", :password => "qwerty1223"}
        response.should redirect_to accountcontrols_path
      end
    end
  end
end