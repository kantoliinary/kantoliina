#encoding: utf-8

require 'spec_helper'

describe StatisticsController do
  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end

  describe "GET #index" do
    context "get :index" do
      it "calls index method with active members" do
        FactoryGirl.create(:membergroup)
        FactoryGirl.create(:member)
        FactoryGirl.create(:member, id: "2", membernumber: "20003")
        get :index
        response.should_not be nil
      end
      it "calls index method with non-active member" do
        FactoryGirl.create(:membergroup)
        FactoryGirl.create(:member, active: "f")
        get :index
        response.should_not be nil
      end
    end
  end
end