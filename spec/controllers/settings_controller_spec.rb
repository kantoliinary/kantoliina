#encoding: utf-8

require 'spec_helper'

describe SettingsController do

  describe "GET #index" do

    context "get :index" do
      it "shows member" do
        admin = FactoryGirl.create(:admin)
        session[:admin_id] = admin.id
        get :index, FactoryGirl.attributes_for(:admin)
      end
    end
  end
end