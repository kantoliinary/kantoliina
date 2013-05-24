require 'spec_helper'


describe MembersController do

  before(:each) do
  admin = FactoryGirl.build(:admin)

  session[:admin] = admin
  end

  describe "GET #new" do
    it "renders the :new view" do
      get :new
      response.should render_template :new
    end

  end


  describe "POST #create" do
    context "with valid attributes" do
      it "saves admin id in session" do
        member = FactoryGirl.build(:member)
        Member.stub(:find_by_login).and_return(member)
        post :create, FactoryGirl.attributes_for(:member)
        flash[:member].should_not be_nil
      end
    end
  end


end