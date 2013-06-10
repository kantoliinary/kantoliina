#encoding: utf-8

class MembergroupsController < ApplicationController

  def index
    @membergroups = Membergroup.includes(:members)
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
    end
    redirect_to membergroups_path
  end

  def delete

    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @membergroups = Membergroup.find_all_by_id(parsed_json["ids"])
    @membergroups.each do |membergroup|
      membergroup.destroy()
    end
    flash[:notice] = "Jäsenryhmä" + (@membergroups.count > 1 ? "et" : "") +" poistettu"
    redirect_to membergroups_path
  end

end