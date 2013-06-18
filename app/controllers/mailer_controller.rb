#encoding: UTF-8
##
# The controller for sending mails to members
#
class MailerController < ApplicationController

  ##
  # Parses an array of IDs from JSON code given as a parameter and selects an array of members based on those IDs.
  def index

    @ids = params[:ids] || params[:id]
    flash[:ids] = params[:ids]
    if params[:id]
      @members = [Member.find_by_id(params[:id])]
    else
      parsed_json = ActiveSupport::JSON.decode(params[:ids])
      @members = Member.find_all_by_id(parsed_json["ids"])

    end
  end

  ##
  # Selects a group of members by chosen ID and sends a mail to their e-mails.
  def create
    if params[:attachment]
      filename = params[:attachment].original_filename
      filepath = params[:attachment].path
    end
    @members = Member.find_all_by_id(params[:member])
    @members.each do |member|
      member.save(:validate => false)
      Billing.mailer(member, params[:additional_message], params[:subject], filename, filepath).deliver
    end
    flash[:notice] = "Sähköposti lähetetty"
    redirect_to members_path
  end
end
