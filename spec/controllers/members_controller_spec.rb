#encoding: utf-8

require 'spec_helper'


describe MembersController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end

  describe "GET #new" do
    context "with not logged in" do
      it "renders not the :new view" do
        session[:admin_id] = nil
        get :new
        response.should_not render_template :new
      end

    end

    context "with logged in" do
      it "renders the :new view" do
        FactoryGirl.create(:membergroup)
        member = FactoryGirl.create(:member)
        member2 = FactoryGirl.create(:member, membernumber: 10000, id: 2)
        get :new
        response.should render_template :new
      end
      it "renders the :new view with empty" do
        get :new
        response.should render_template :new
      end
    end
  end


  describe "POST #create" do
    context "with valid attributes" do
      it "member will be created" do
        FactoryGirl.create(:membergroup)
        post :create, :member => {:firstnames => "John", :surname => "Doe", :municipality => "f", :zipcode => "00540", :address => "street 7", :postoffice => "Helsinki", :country => "Suomi", :email => "sgafd@gmaik.com", :membergroup_id => "1", :membernumber => "33333", :membershipyear => "2014", :paymentstatus => "t", :invoicedate => "08/08/2013", :active => "t", :lender => "f", :support => "f"}, :nextyear => true, :sendinvoice => true
        flash[:notice].should == "Jäsen lisätty"
      end

      it "member will be created and email will not be sent" do
        FactoryGirl.create(:membergroup)
        post :create, :member => {:firstnames => "John", :surname => "Doe", :municipality => "f", :zipcode => "00540", :address => "street 7", :postoffice => "Helsinki", :country => "Suomi", :email => "sgafd@gmaik.com", :membergroup_id => "1", :membernumber => "33333", :membershipyear => "2014", :paymentstatus => "t", :invoicedate => "08/08/2013", :active => "t", :lender => "f", :support => "f"}, :nextyear => true, :sendinvoice => false
        flash[:notice].should == "Jäsen lisätty"
        response.should redirect_to new_member_path
      end
    end
    context "with invalid attributes" do
      it "member will be created" do
        post :create
        flash[:notice].should == @member

      end
      it "doesn't create two times" do
        FactoryGirl.create(:membergroup)
        post :create, :member => {:firstnames => "John", :surname => "Doe", :municipality => "f", :zipcode => "00540", :address => "street 7", :postoffice => "Helsinki", :country => "Suomi", :email => "sgafd@gmaik.com", :membergroup_id => "1", :membernumber => "33333", :membershipyear => "2014", :paymentstatus => "t", :invoicedate => "08/08/2013", :active => "t", :lender => "f", :support => "f"}, :nextyear => true, :sendinvoice => false
        post :create, :member => {:firstnames => "John", :surname => "Doe", :municipality => "f", :zipcode => "00540", :address => "street 7", :postoffice => "Vantaa", :country => "Algeria", :email => "other@gmaik.com", :membergroup_id => "1", :membernumber => "33334", :membershipyear => "2014", :paymentstatus => "t", :invoicedate => "09/08/2013", :active => "t", :lender => "f", :support => "f"}, :nextyear => true, :sendinvoice => false
        flash[:error].should == "Jäsen samoilla nimi- ja osoitetiedoilla on jo olemassa"
      end
    end
  end

  describe "GET #index" do

    context "get :index" do
      it "shows members" do
        get :index
        response.should render_template :index
      end
    end
  end

  describe "GET #edit" do

    context "get :edit" do
      it "renders the :edit view" do
        member = FactoryGirl.create(:member)
        get :edit, FactoryGirl.attributes_for(:member)
        response.should render_template :edit
      end
    end

  end

  describe "GET #update" do

    context "with valid attributes" do

      it "update works" do
        member = FactoryGirl.build(:member)
        Member.stub(:find).and_return(member)
        get :update, FactoryGirl.attributes_for(:member)
        flash[:notice].should == "Tiedot muutettu"
      end

      it "redirects to edit_member_path" do
        member = FactoryGirl.build(:member)
        Member.stub(:find).and_return(member)
        get :update, FactoryGirl.attributes_for(:member)
        response.should redirect_to members_path
      end
    end
    context "with invalid attributes" do
      it "update doesn't work" do
        member = FactoryGirl.create(:member)
        get :update,
            :id => member.id,
            :member => {:surname => ""}
        response.should redirect_to edit_member_path
      end
    end
  end

  describe "POST #payment" do
    it "changes paymentstatus" do
      member = FactoryGirl.create(:member)
      Member.stub(:find).and_return(member)
      post :payment, :ids => "{\"ids\":[\"1\"]}"
      flash[:notice].should == "Maksustatus muutettu maksaneeksi"
    end

    it "doesn't change paymentstatus" do
      member = FactoryGirl.create(:member, membershipyear: 2012)
      Member.stub(:find).and_return(member)
      post :payment, :ids => "{\"ids\":[\"1\"]}"
      post :payment, :ids => "{\"ids\":[\"1\"]}"
      flash[:error].should == "Jäsen on jo maksanut"
    end
  end

  describe "POST #unpayment" do
    it "changes paymentstatus" do
      member = FactoryGirl.create(:member, paymentstatus: true)
      Member.stub(:find).and_return(member)
      post :unpayment, :ids => "{\"ids\":[\"1\"]}"
      flash[:notice].should == "Maksustatus muutettu maksamattomaksi"
    end

    it "doesn't change paymentstatus" do
      member = FactoryGirl.create(:member, paymentstatus: false)
      Member.stub(:find).and_return(member)
      post :unpayment, :ids => "{\"ids\":[\"1\"]}"
      flash[:error].should == "Jäsen on jo maksamaton"
    end
  end

  describe "POST #delete" do
    it "deletes a member" do
      member = FactoryGirl.create(:member)
      Member.stub(:find).and_return(member)
      post :delete, :ids => "{\"ids\":[\"1\"]}"
      flash[:notice].should == "Jäsen poistettu"
    end
  end

  describe "POST #search" do
    it "filters members by ids" do
      member = FactoryGirl.create(:member)
      Member.stub(:find).and_return(member)
      post :search, FactoryGirl.attributes_for(:member)
    end
  end

  describe "GET #search" do
    it "should return json" do
      member = FactoryGirl.create(:member)
      FactoryGirl.create(:membergroup)
      response_json = [member].to_json
      get :search, :keyword => "John", :format => :json
      response.body.should == response_json
    end
    it "should return only deleted member" do
      member = FactoryGirl.create(:member, :active => "f")
      FactoryGirl.create(:member, :id => "2", :membernumber => "10003")
      FactoryGirl.create(:membergroup)
      response_json = [member].to_json
      get :search, :active => "1", :format => :json
      response.body.should == response_json
    end
    it "should return only payment member" do
      member = FactoryGirl.create(:member, :paymentstatus => "t")
      FactoryGirl.create(:member, :id => "2", :membernumber => "10003")
      FactoryGirl.create(:membergroup)
      response_json = [member].to_json
      get :search, :paymentstatus => "1", :format => :json
      response.body.should == response_json
    end
    it "should return only support member" do
      member = FactoryGirl.create(:member, :support => "t")
      FactoryGirl.create(:member, :id => "2", :membernumber => "10003")
      FactoryGirl.create(:membergroup)
      response_json = [member].to_json
      get :search, :support => "1", :format => :json
      response.body.should == response_json
    end
    it "should return only lender member" do
      member = FactoryGirl.create(:member, :lender => "t")
      FactoryGirl.create(:member, :id => "2", :membernumber => "10003")
      FactoryGirl.create(:membergroup)
      response_json = [member].to_json
      get :search, :lender => "1", :format => :json
      response.body.should == response_json
    end
    it "should return member with searched membergroup" do
      member = FactoryGirl.create(:member)
      FactoryGirl.create(:member, :id => "2", :membernumber => "10003", :membergroup_id => "2")
      FactoryGirl.create(:membergroup, :name => "jotain")
      FactoryGirl.create(:membergroup, :id => "2")
      response_json = [member].to_json
      membergroups = ["1"]
      get :search, :membergroups => membergroups, :format => :json
      response.body.should == response_json
    end
    it "should return member with searched municipality" do
      member = FactoryGirl.create(:member)
      FactoryGirl.create(:member, :id => "2", :membernumber => "10003", :municipality => "a")
      FactoryGirl.create(:membergroup)
      response_json = [member].to_json
      municipalitys = ["f"]
      get :search, :municipalitys => municipalitys, :format => :json
      response.body.should == response_json
    end
  end
  describe "POST #addressdata" do
    context "post :addressdata" do
      it "renders addressdata" do
        FactoryGirl.create(:member)
        FactoryGirl.create(:member, :id => "2", :membernumber => "10004")
        FactoryGirl.create(:membergroup)
        post :addressdata, :ids => "{\"ids\":[\"1\", \"2\"]}"
        response.should render_template :addressdata
      end
    end
  end
  describe "POST #addressdata" do
    context "post :addressdata" do
      it "return sended members" do
        member = FactoryGirl.create(:member)
        member2 = FactoryGirl.create(:member, :id => "2", :membernumber => "10004")
        FactoryGirl.create(:member, :id => "3", :membernumber => "10002")
        FactoryGirl.create(:membergroup)
        post :addressdata, :ids => "{\"ids\":[\"1\", \"2\"]}"
        expect(assigns(:members)).to match_array([member, member2])
      end
    end
  end

  describe "POST #import" do
    context "with valid file" do
      it "saves members to db" do

        @file = fixture_file_upload('/files/test.xml', 'test/xml')
        post :import, :file => @file
        flash[:notice].should == "Tiedoston tuonti onnistui"

      end
    end
    context "with invalid file" do
      it "doesn't work" do


        post :import, :file => "invalid_file.txt"
        flash[:notice].should == "Virheellinen tiedosto tai tiedostossa on jo lisäytyjä jäseniä"

      end
    end
    context "without selected file" do
      it "doesn't work" do

        post :import
        flash[:error].should == "Valitse ensin tiedosto"

      end
    end
  end


end



