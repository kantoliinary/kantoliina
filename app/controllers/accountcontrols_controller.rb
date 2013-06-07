##
# The controller for editing admin and partner accounts
class AccountcontrolsController < ApplicationController

  ##
  #
  def index
    @admin = flash[:admin] || Admin.first
    @partner = flash[:partner] || Partner.first
  end
end