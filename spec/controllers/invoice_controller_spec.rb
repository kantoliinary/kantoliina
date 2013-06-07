#encoding: utf-8

require 'spec_helper'

describe InvoiceController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end

  describe "POST #index" do
    it 'finds members with given ids' do
      FactoryGirl.create(:membergroup)
      post :index, :ids => "{\"ids\":[\"1\"]}"
      response.should render_template :index
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
        response.should redirect_to members_path
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


