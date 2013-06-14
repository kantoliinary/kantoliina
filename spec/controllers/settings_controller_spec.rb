#encoding: utf-8

require 'spec_helper'

describe SettingsController do
  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end


  describe "GET #index" do


    context "get :index" do
      it "shows billing-email template" do
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        get :index
      end
    end


    context "get :index" do
      it "shows reminder-email template when :temp == 2" do
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        get :index, :temp => "2"
      end
    end
  end

end
