#encoding: utf-8
##
# The controller for account editing functionality.

class AdminsController < ApplicationController

  ##
  #  Checks if the account changes submitted by the admin are valid, executes them if they are and returns appropriate messages to the admin.
  def update
    admin = Admin.find(params[:id]).try(:authenticate, params[:old_password])
    if admin
      unless params[:admin][:password].empty?
        if admin.update_attributes(params[:admin])
          flash[:adminnotice] = "Tiedot päivitetty"
        else
          flash[:admin] = admin
        end
      else
        admin.username = params[:admin][:username]
        admin.email = params[:admin][:email]
        if admin.validate_username && admin.validate_email && admin.save(:validate => false)
          flash[:adminnotice] = "Käyttäjätunnus päivitetty"
        else
          flash[:admin] = admin
        end
      end
    else
      flash[:admin] = admin
      flash[:adminerror] = "Tunnuksen muokkaus ei onnistunut"
    end
    redirect_to accountcontrols_path and return
  end
end