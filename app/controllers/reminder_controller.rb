#encoding: UTF-8
##
# The controller for sending invoices to members
#
class ReminderController < ApplicationController

  ##
  # Parses an array of IDs from JSON code given as a parameter and selects an array of members based on those IDs.
  def index

    @ids = params[:ids] || params[:id]

    if params[:id]
      @members = [Member.find_by_id(params[:id])]
    else
      parsed_json = ActiveSupport::JSON.decode(params[:ids])
      @members = Member.find_all_by_id(parsed_json["ids"], :conditions => ["paymentstatus = ? AND invoicedate IS NOT ?", false, nil], :joins => [:membergroup])
      if @members.count == 0
        flash[:error] = "Vain laskunsa maksamatta jättäneille jäsenille voi lähettää maksumuistutuksen"
        redirect_to members_path
      elsif @members.count < parsed_json["ids"].length
        flash[:error] = "Laskuttamattomia tai laskunsa jo maksaneita ei otettu listaan"
      end
    end


    if params[:function] == 'preview'
      @top_message = params[:top_message]
      @bottom_message = params[:bottom_message]
      @preview = InvoiceHelper.preview @top_message, @bottom_message, Rails.root.join("app", "views", "billing", "reminder_email.html.haml").to_s
    end
  end

  ##
  # Loads the default reminder template to the editor
  def load_default

    @f= Hash.new

    EditorHelper.load_default Rails.root.join("app", "views", "billing", "default_reminder_email.html.haml").to_s, @f

    @f.each do |key, value|
      flash[key] = value
    end
    redirect_to  reminder_edit_path
  end

  ##
  # Selects a group of members by chosen ID and sends an reminder to their e-mails.
  def create
    @members = Member.find_all_by_id(params[:member])
    @members.each do |member|
      member.reminderdate = Time.now
      member.paymentstatus = false;
      member.save(:validate => false)
      Billing.reminder_email(member, params[:top_message], params[:bottom_message], params[:subject]).deliver
    end
    flash[:notice] = "Maksumuistutukset lähetetty"
    redirect_to members_path
  end

  ##
  #  Loads the saved reminder template to the editor page and sends error messages to the editor page
  def edit
    @error = flash[:error] || ""
    @errorline = flash[:errorline] || 0
    @template = flash[:template] || File.open(Rails.root.join("app", "views", "billing", "reminder_email.html.haml").to_s, 'r') do |f|
      template = ""
      while line = f.gets
        template += line
      end
      template
    end
  end

  ##
  # Sends a reminder template submitted by the user and uses the helper update method to validate and save it
  def update
    template = params[:template]
    @f= Hash.new
    EditorHelper.update params[:function], template, Rails.root.join("app", "views", "billing", "reminder_email.html.haml").to_s, @f

    @f.each do |key, value|
      flash[key] = value
    end
    redirect_to reminder_edit_path
  end

end


