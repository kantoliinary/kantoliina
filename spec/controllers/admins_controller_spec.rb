#encoding: utf-8

require 'spec_helper'

describe AdminsController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
    @admin2 = FactoryGirl.create(:admin, password: "ouujeea13")
  end

  describe "PUT #update" do

    context "with valid attributes" do

      it "update works" do
        put :update, FactoryGirl.attributes_for(@admin2)
        response.should redirect_to accountcontrol_index_path and return
      end
    end
    context "with invalid attributes" do
      it "update doesn't work" do
        session[:admin_id] = nil
        put :update, FactoryGirl.attributes_for(@admin2)
        response.should redirect_to accountcontrol_index_path and return
      end
    end
  end
end