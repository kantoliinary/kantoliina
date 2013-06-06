#encoding: UTF-8
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
    template = params[:template]
    if validate_invoice_template template
      File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'w') do |f|
        f.puts template
      end
    end
    redirect_to settings_path
  end

  private

  def validate_invoice_template template
    deep = 0
    line_number = 1
    template.split(/\r?\n/).each do |row|
      unless row.strip.empty?
        unless row.match(/\A[ ]{0,#{deep}}\S{1}.*\z/)
          flash[:error] = "Virheellinen sisennys rivillä #{line_number}: #{row}"
          flash[:template] = template
          flash[:errorline] = line_number
          return false
        end
        deep = row.index(/\S{1}/)
        puts deep
        if row.match(/\A\s*%.*\z/)
          deep += 2
        end
      end
      line_number += 1
    end

    true
  end
end