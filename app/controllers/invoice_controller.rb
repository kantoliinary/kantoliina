#encoding: UTF-8
##
# The controller for sending invoices to members
#
class InvoiceController < ApplicationController

  ##
  # Parses an array of IDs from JSON code given as a parameter and selects an array of members based on those IDs.
  def index

    @ids = params[:ids] || params[:id]

    if params[:id]
      @members = [Member.find_by_id(params[:id])]
    else
      parsed_json = ActiveSupport::JSON.decode(params[:ids])
      @members = Member.find_all_by_id(parsed_json["ids"], :conditions => ['paymentstatus = ? OR membergroups.onetimefee = ?', false, false], :joins => [:membergroup])
    end

    if params[:function] == 'preview'
      @preview = InvoiceHelper.preview params[:top_message], params[:bottom_message], Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s
    end
  end

  #def index_editor
  #
  #  @error = flash[:error] || ""
  #  @errorline = flash[:errorline] || 0
  #
  #  @template = flash[:template] || File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r') do |f|
  #    template = ""
  #    while line = f.gets
  #      template += line
  #    end
  #    template
  #  end
  #  render "settings/invoice_edit"
  #end

  ##
  # Loads the default invoice template to the editor
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
      Billing.bill_email(member, params[:top_message], params[:bottom_message], params[:subject]).deliver
    end
    flash[:notice] = "Laskut lähetetty"
    redirect_to members_path
  end

  ##
  #  Loads the saved invoice template to the editor page and sends error messages to the editor page
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

  ##
  # Sends an invoice template submitted by the user and uses the helper update method to validate and save it
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