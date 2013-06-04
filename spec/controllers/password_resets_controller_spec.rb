require 'spec_helper'

describe PasswordResetsController do

  describe "GET #new" do
    it "renders the :reset view" do
      get :new
      response.should render_template :new
    end
  end

  describe "Post #create" do
    it "redirects to login path" do
      admin = FactoryGirl.build(:admin)
      Admin.stub(:find_by_email).and_return(admin)
      post :create, FactoryGirl.attributes_for(:admin)
      response.should redirect_to login_path
    end
    it "password resets" do
      admin = FactoryGirl.build(:admin)
      Admin.stub(:find_by_email).and_return(admin)

      post :create, FactoryGirl.attributes_for(:admin)
      admin.password != "qwerty123"
      response.should redirect_to login_path
    end
  end

end