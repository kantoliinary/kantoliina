#encoding: UTF-8
##
# The controller for sending invoices to members
#
class InvoiceController < ApplicationController


  ##
  # Parses an array of IDs from JSON code given as a parameter and selects an array of members based on those IDs.
  def index
    if params[:id]
      @members = [Member.find_by_id(params[:id])]
    else
      parsed_json = ActiveSupport::JSON.decode(params[:ids])

      @members = Member.find_all_by_id(parsed_json["ids"], :conditions => ['paymentstatus LIKE ? OR membergroups.onetimefee LIKE ?', false, false], :joins => [:membergroup])
    end

  end
  ##
  #
  def index_editor

    @error = flash[:error] || ""
    @errorline = flash[:errorline] || 0

    @template = flash[:template] || File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r') do |f|
      template = ""
      while line = f.gets
        template += line
      end
      template
    end
    render "settings/invoice_edit"
  end


  def load_default

    @f= Hash.new

    EditorHelper.load_default Rails.root.join("app", "views", "billing", "default_bill.html.haml").to_s, @f

    @f.each do |key, value|
      flash[key] = value
    end
    redirect_to invoice_edit_path
  end

  ##
  # Selects a group of members by chosen ID and sends an invoice to their e-mails.
  def create
    @members = Member.find_all_by_id(params[:member])
    @members.each do |member|
      member.invoicedate = Time.now
      member.paymentstatus = false;
      member.save(:validate => false)
      Billing.bill_email(member, params[:top_message], params[:bottom_message]).deliver
    end
    redirect_to members_path
  end

  def edit
    @error = flash[:error] || ""
    @errorline = flash[:errorline] || 0
    @template = flash[:template] || File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r') do |f|
      template = ""
      while line = f.gets
        template += line
      end
      template
    end
  end

  def update

    template = params[:template]
    @f= Hash.new
    EditorHelper.update params[:function], template, Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, @f


    @f.each do |key, value|
      flash[key] = value
    end

    redirect_to invoice_edit_path

  end
end