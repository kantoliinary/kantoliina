#encoding: utf-8

class MembergroupsController < ApplicationController

  def index
    @membergroups = Membergroup.includes(:members)
  end

  def new
    @membergroup = flash[:membergroup] || Membergroup.new
    @submit_text = "Lisää"
  end

  def create
    @membergroup = Membergroup.new(params[:membergroup])

    if @membergroup.save
      flash[:notice] = "Jäsenryhmä lisätty"
    else
      flash[:membergroup] = @membergroup
    end
    redirect_to new_membergroup_path
  end

  def edit
    @membergroup = flash[:membergroup] || Membergroup.find(params[:id])
    @submit_text = "Tallenna muutokset"
  end

  def update
    @membergroup = Membergroup.find(params[:id])
    if @membergroup.update_attributes(params[:membergroup])
      flash[:notice] = "Tiedot muutettu"
    else
      flash[:membergroup] = @membergroup
      redirect_to edit_membergroup_path @membergroup and return
    end
    redirect_to membergroups_path
  end

end