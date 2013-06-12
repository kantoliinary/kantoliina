#encoding: UTF-8
##
# The controller for sending invoices to members
#
class ReminderController < ApplicationController

  ##
  # Parses an array of IDs from JSON code given as a parameter and selects an array of members based on those IDs.
  def index
    if params[:id]
      @members = [Member.find_by_id(params[:id])]
      puts @members
      puts "aaaaa"
    else
      parsed_json = ActiveSupport::JSON.decode(params[:ids])
      @members = Member.find_all_by_id(parsed_json["ids"], :conditions => "membergroup_id != 3")
    end
  end


  def create
    @members = Member.find_all_by_id(params[:member])
    @members.each do |member|
      member.invoicedate = Time.now
      member.paymentstatus = false;
      member.save(:validate => false)
      Billing.reminder_email(member, params[:top_message], params[:bottom_message]).deliver
    end
    redirect_to members_path
  end
end