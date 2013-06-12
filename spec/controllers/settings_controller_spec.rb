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

  describe "#update" do

    it "should update an e-mail with valid attributes" do
      file = mock('file')
      File.should_receive(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, "w").and_yield(file)
      file.should_receive(:puts).with("text")
      post :update, :template => "text"
      response.should redirect_to settings_path
    end

    it "should update a reminder e-mail with valid attributes" do
      file = mock('file')
      File.should_receive(:open).with(Rails.root.join("app", "views", "billing", "reminder_email.html.haml").to_s, "w").and_yield(file)
      file.should_receive(:puts).with("text")
      post :update,:temp => "2", :template => "text"
      response.should redirect_to settings_path(:temp=>2)

    end
  end

  it "should not update e-mail with invalid row" do
    file = mock('file')
    File.stub(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, "w").and_yield(file)
    post :update, :template => "             text"
    flash[:error].should include ("Virheellinen sisennys rivillä")
  end

  it "should work with a line starting with %" do
    file = mock('file')
    File.stub(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, "w").and_yield(file)
    file.should_receive(:puts).with("%br")
    post :update, :template => "%br"
    response.should redirect_to settings_path
  end
end