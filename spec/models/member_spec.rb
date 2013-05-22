# spec/models/contact_spec.rb
require 'spec_helper'

describe Member do
  it "has a valid factory" do
    FactoryGirl.create(:member).should be_valid
  end



end
