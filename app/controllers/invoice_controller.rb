class InvoiceController < ApplicationController

  ##
  # Parses an array of IDs from JSON code given as a parameter and selects an array of members based on those IDs.
  def index
    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @members = Member.find_all_by_id(parsed_json["ids"])
  end

  ##
  #Selects a group of members by chosen ID and sends an invoice to their e-mails.
  def create
    @members = Member.find_all_by_id(params[:member])
    @members.each do |member|
      member.invoicedate = Time.now
      Billing.bill_email(member, params[:additional_message]).deliver
    end
    redirect_to members_path
  end

  def update
    File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'w') do |f|
      f.puts params[:template]
    end
    redirect_to settings_path
  end
end