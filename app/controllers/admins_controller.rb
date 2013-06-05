#encoding: utf-8
##
# The controller for Admin class.

class AdminsController < ApplicationController

  def update
    admin = Admin.find(params[:id]).try(:authenticate, params[:old_password])
    if admin
      unless params[:admin][:password].empty?
        if admin.update_attributes(params[:admin])
          flash[:adminnotice] = "Salasana päivitetty"
        else
          flash[:admin] = admin
        end
      else
        admin.username = params[:admin][:username]
        if admin.validate_username && admin.save(:validate => false)
          flash[:adminnotice] = "Käyttäjätunnus päivitetty"
        else
          flash[:admin] = admin
        end
      end
    else
      flash[:admin] = admin
      flash[:adminerror] = "Tunnuksen muokkaus ei onnistunut!"
    end
    redirect_to accountcontrol_index_path and return
  end
end