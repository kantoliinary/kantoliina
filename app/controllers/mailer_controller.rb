#encoding: UTF-8
##
# The controller for sending mails to members
#
class MailerController < ApplicationController

  ##
  # Parses an array of IDs from JSON code given as a parameter and selects an array of members based on those IDs.
  def index
    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @members = Member.find_all_by_id(parsed_json["ids"])
  end

  ##
  # Selects a group of members by chosen ID and sends a mail to their e-mails.
  def create
    @members = Member.find_all_by_id(params[:member])
    @members.each do |member|
      member.save(:validate => false)
      Billing.send_email(member, params[:additional_message], params[:subject]).deliver
    end
    redirect_to members_path
  end

  ##
  # Loads the mailer haml
  def update
    unless (params[:temp] == "2")
      mail = params[:template]
      File.open(Rails.root.join("app", "views", "mailer", "mailer.html.haml").to_s, 'w') do |f|
        f.puts mail
      end
      redirect_to settings_path
    else
      redirect_to settings_path
    end
  end
end
