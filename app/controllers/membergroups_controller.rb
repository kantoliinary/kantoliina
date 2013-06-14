#encoding: utf-8
##
# The controller for class Membergroup.

class MembergroupsController < ApplicationController

  def index
    @membergroups = Membergroup.includes(:members)
  end

  ##
  # Shows new membergroup page to the admin.
  # If an old membergroup is in flash[:member], saves it to @member.

  def new
    @editpage = false
    @membergroup = flash[:membergroup] || Membergroup.new
    @submit_text = "Lisää"
  end


  ##
  # Creates a new membergroup with params[:membergroup] and tries to save it.
  # If save succeeds, adds flash[:notice] message, otherwise adds members information to flash[:member].
  # Redirects to new member page.
  def create
    @membergroup = Membergroup.new(params[:membergroup])

    if @membergroup.save
      flash[:notice] = "Jäsenryhmä lisätty"
      redirect_to membergroups_path
    else
      flash[:membergroup] = @membergroup
      redirect_to new_membergroup_path
    end
  end


  ##
  # Edits the current Membergroup with right parameters
  def edit
    @editpage = true
    #@membergroup = Membergroup.includes(:members).find(params[:id])
    @membergroup = Membergroup.find(params[:id])


    unless @membergroup.members.count == 0
      @editpage = false
    end
    @membergroup = flash[:membergroup] || Membergroup.find(params[:id])
    @submit_text = "Tallenna muutokset"

  end


  ##
  # Replaces the selected attributes of a single membergroup
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

  ##
  # Identifies a membergroup by id and removes it from the database
  def destroy
    membergroup = Membergroup.find(params[:id])
    membergroup.destroy()
    flash[:notice] = "Jäsenryhmä poistettu"
    redirect_to membergroups_path
  end

end