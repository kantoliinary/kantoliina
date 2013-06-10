#encoding: utf-8

class MembergroupsController < ApplicationController

  def index
    @membergroups = Membergroup.includes(:members)
  end


  def create
    @membergroup = Membergroup.new(params[:membergroup])
    @membergroup.membershipyear = (Time.now.year+1).to_i
    @membergroup.paymentstatus = false
    if @membergroup.save
      flash[:notice] = "Jäsenryhmä lisätty"
    else
      flash[:membergroup] = @membergroup
    end
    redirect_to new_membergroup_path
  end

  def edit
    @editpage = true
    @membergroup = flash[:membergroup] || Membergroup.find(params[:id])
    @submit_text = "Tallenna muutokset"
  end

  def update
    @membergroup = Membergroup.find(params[:id])
    if @membergroup.update_attributes(params[:membergroup])
      flash[:notice] = "Tiedot muutettu"
    else
      flash[:membergroup] = @membergroup
    end
    redirect_to membergroups_path
  end

  def destroy
    membergroup = Membergroup.find(params[:id])
    membergroup.destroy()
    flash[:notice] = "Jäsenryhmä" + (@membergroups.count > 1 ? "et" : "") +" poistettu"
    redirect_to membergroups_path
  end

end