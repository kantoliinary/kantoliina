#encoding: utf-8
##
# The controller for Admin class.

class AdminsController < ApplicationController

  def update
    admin = Admin.find(params[:id]).try(:authenticate, params[:old_password])
    if admin
      if admin.update_attributes(params[:admin])
        flash[:adminnotice] = "Tunnusta muokattu"
      else
        flash[:admin] = admin
      end
    else
      flash[:admin] = admin
      flash[:adminerror] = "Tunnuksen muokkaus ei onnistunut!"
    end
    redirect_to accountcontrol_index_path and return
  end
end