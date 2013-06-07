#encoding: utf-8

require 'spec_helper'

describe AccountcontrolsController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id

  end

  describe "GET #index" do

    context "get :index" do

      it "should render the template" do

        get :index
        response.should render_template :index

      end
    end
  end
end


