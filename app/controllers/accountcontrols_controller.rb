##
# The controller for editing admin and partner accounts
class AccountcontrolsController < ApplicationController

  ##
  #  Fetches the account information for an admin and a partner in the account controls page
  def index
    @admin = flash[:admin] || Admin.first
    @partner = flash[:partner] || Partner.first
  end
end