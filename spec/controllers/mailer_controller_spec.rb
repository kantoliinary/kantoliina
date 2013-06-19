#encoding: utf-8

require 'spec_helper'

describe MailerController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end

  describe "POST #index" do
    it 'finds members with given ids' do
      FactoryGirl.create(:membergroup)
      post :index, :ids => "{\"ids\":[\"1\"]}"
      response.should render_template :index
      response.should be_success
    end

    it 'finds members with given id' do
      FactoryGirl.create(:membergroup)
      post :index, :id => 1
      response.should render_template :index
      response.should be_success
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
        post :create, :additional_message => "fa", :subject => "topic", :sender => "testi@mail.com"
        flash[:notice].should == "Sähköposti lähetetty"
        response.should redirect_to members_path
      end
    end
    it "sends mail with attachment" do
      FactoryGirl.create(:membergroup)
      member = FactoryGirl.create(:member)
      member2 = FactoryGirl.create(:member, membernumber: 54321, id: 2)
      members = [member, member2]
      Member.stub(:find_all_by_id).and_return(members)
      @file = fixture_file_upload('/files/test.xml', 'text/xml')
      post :create, :attachment => @file, :sender => "testi@mail.com"
      flash[:notice].should == "Sähköposti ja liitetiedosto lähetetty"

    end
  end
end
