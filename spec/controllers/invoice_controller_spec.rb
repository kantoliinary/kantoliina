#encoding: utf-8

require 'spec_helper'

describe InvoiceController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end

  describe "POST #index" do
    it 'finds members with given id' do
      FactoryGirl.create(:membergroup)
      post :index, :id => 1
      response.should render_template :index
      response.should be_success
    end
    it 'finds members with given ids' do
      FactoryGirl.create(:membergroup)
      post :index, :ids => "{\"ids\":[\"1\"]}"
      response.should render_template :index
      response.should be_success
    end
  end

  describe 'POST #index preview' do
    it 'should direct to preview method' do
      FactoryGirl.create(:membergroup)
      post :index, :ids => "{\"ids\":[\"1\"]}", :function => 'preview'
      response.should be_success

    end

    it 'should preview the e-mail' do
      @file = mock('file')
      @file.should_receive(:gets)
      File.should_receive(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r').and_yield(@file)
      post :index, :ids => "{\"ids\":[\"1\"]}", :function => 'preview'
    end
  end

  describe "POST #create" do

    context "with valid attributes" do
      it "mail will be created" do
        FactoryGirl.create(:membergroup)
        member = FactoryGirl.create(:member)
        member2 = FactoryGirl.create(:member, membernumber: 54321, id: 2)
        members = [member, member2]
        Member.stub(:find_all_by_id).and_return(members)
        post :create, :additional_message => "fa"
        response.should_not be_success
        response.should redirect_to members_path
      end
    end
  end

  describe "#update" do
    it "should preview an e-mail with valid attributes" do
      #file = mock('file')
      #File.should_receive(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'w').and_yield(file)
      post :update, :function => "preview", :template => "dasaas"
      flash[:template].should == "dasaas"

      response.should redirect_to invoice_edit_path
    end

    it "should update an e-mail with valid attributes" do
      file = mock('file')
      File.should_receive(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'w').and_yield(file)
      file.should_receive(:puts).with("text")
      post :update, :template => "text", :function => "save"
      response.should redirect_to invoice_edit_path
    end

    it "should not update e-mail with invalid row" do
      file = mock('file')
      File.stub(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, "w").and_yield(file)
      post :update, :template => "             text", :function => "save"
      flash[:error].should include ("Virheellinen sisennys rivillä")
    end
    #
    it "should work with a line starting with %" do
      file = mock('file')
      File.stub(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, "w").and_yield(file)
      file.should_receive(:puts).with("%br")
      post :update, :template => "%br", :function => "save"
      response.should redirect_to invoice_edit_path
    end
  end

  describe "GET #edit" do
    it "should open an editable file" do
      file = mock('file')

      File.stub(:open).with(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, "r").and_yield(file)

      file.should_receive(:gets)
      get :edit
    end
    it "should render edit-view" do
       get :edit
      response.should render_template :edit
    end
  end

  describe "GET #load_default" do
    it "should load defalut template" do

      get :load_default
      flash[:template].should_not be_nil
      response.should redirect_to invoice_edit_path

    end
    it "should redirect to invoice edit after reading the default mail" do
      file = mock('file')

      File.stub(:open).with(Rails.root.join("app", "views", "billing", "default_bill.html.haml").to_s, 'r')
      # file.should_receive(:gets)
      get :load_default
      response.should redirect_to invoice_edit_path

    end

  end
end




