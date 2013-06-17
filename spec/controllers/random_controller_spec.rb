#encoding: utf-8

require 'spec_helper'

describe RandomController do

  before(:each) do
    admin = FactoryGirl.create(:admin)
    session[:admin_id] = admin.id
  end

  describe "POST #index" do
    it 'finds members with given ids' do
      post :index, :ids => "{\"ids\":[\"1\"]}"
    end
  end
end