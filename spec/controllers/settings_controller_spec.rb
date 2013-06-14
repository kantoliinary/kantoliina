#encoding: utf-8

require 'spec_helper'

describe SettingsController do
  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end


  #describe "GET #index" do
  #
  #
  #  context "get :index" do
  #    it "shows billing-email template" do
  #      get :index
  #    end
  #  end
  #end
  #
  #
  #describe "GET #load_default" do
  #  context "get :load_default" do
  #    it "opens default mail" do
  #      get :load_default
  #      redirect_to settings_path
  #    end
  #
  #  end


  context "get #validate" do

    it "should not update bill with invalid row" do
      file = mock('file')
      File.stub(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, "w").and_yield(file)
      post :validate_invoice_template, :template => "             text"
      flash[:error].should include ("Virheellinen sisennys rivillä")
    end

    it "should work with a line starting with %" do
      file = mock('file')
      File.stub(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, "w").and_yield(file)
      file.should_receive(:puts).with("%br")
      post :validate_invoice_template, :template => "%br"
      response.should redirect_to settings_path
    end
  end
end