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

    it "should update an e-mail with valid attributes" do
      file = mock('file')
      post :update, :function => "preview"

      response.should redirect_to invoice_edit_path
    end

    it "should update a reminder e-mail with valid attributes" do
      file = mock('file')
      File.should_receive(:open).with(Rails.root.join("app", "views", "billing", "reminder_email.html.haml").to_s, "w").and_yield(file)
      file.should_receive(:puts).with("text")
      post :update, :function => "save"
      response.should redirect_to invoice_edit_path

    end
  end

end


