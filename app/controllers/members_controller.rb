#encoding: utf-8
##
# The controller for class Member.

class MembersController < ApplicationController
  before_filter :require_login

  ##
  # Shows new member page to the admin.
  # If old member in flash[:member], saves it to @member.

  def new
    @member = flash[:member] || Member.new
  end

  ##
  # Creates a new member with params[:member] and tries to save it.
  # If save succeeds, adds flash[:notice] message, otherwise adds members information to flash[:member].
  # Redirects to new member page.

  def create
    @member = Member.new(params[:member])
    @member.expirationdate += 1
    if @member.save
      flash[:notice] = "Jäsen lisätty!"
    else
      flash[:member] = @member
    end
    redirect_to new_member_path
  end

  def invoice
    @ids = params[:ids]
    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @members = Member.find_all_by_id(parsed_json["ids"])
    @viite = generate_refnumber(parsed_json["ids"])
  end

  def generate_refnumber(param)
    @number = Hash.new
    @members.each do |member|
      input = member.membernumber.to_s.reverse!
      base = "731" * 50

      index = 0
      sum = 0

      input.each_byte do |b|
        result = b.chr.to_i * base[index % 3].chr.to_i
        sum = sum + result
        index = index + 1

      end
      difference = (10 - (sum % 10)) % 10

      @number[member.id] = "#{difference}#{input}".reverse

    end
    return @number

  end

  ##
  # Deletes the member with params[:member] and tries to save it.
  # The interface informs the admin whether the save succeeded or not.
  # Redirects to the list page.

  def destroy
    @member = Member.find(params[:id])
    if @member == false
      flash[:notice] = "Jäsentä ei löydetty!"
    else
      @member.membership = false
      if @member.save
        flash[:notice] = "Jäsen poistettu"
        redirect_to members_path
      else
        flash[:notice] = "Jäsenen poisto ei onnistunut"
        redirect_to members_path
      end
    end
  end

  ##
  # Lists all members to @members and shows the list page.

  def index
    @membergroups = Membergroup.all
    @all_search_fields = Member.all_search_fields
    @selected_search_fields = params[:search_fields] || {}
    @keyword = params[:keyword] || ""
    @membership = params[:membership] || "1"
    @paymentstatus = params[:paymentstatus] || "2"
    @members = search_with_filter(@keyword, @selected_search_fields, @membership, @paymentstatus)

  end

  ##
  #Edits the current Member with right parameters.

  def edit
    @member = flash[:member] || Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(params[:member])
      flash[:notice] = "Tiedot muutettu!"
    else
      flash[:member] = @member
    end
    redirect_to edit_member_path
  end

  def send_invoices
    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    members = Member.find_all_by_id(parsed_json["ids"])
    members.each do |member|
      Billing.bill_email(member).deliver
    end
  end

  private

##
# Checks that admin is logged in and redirects the admin to the login form if not.

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end

##
# Checks if admin is logged in.
#@return boolean value is user logged in.

  def logged_in?
    !!session[:admin]
  end

##
# Filters
#


  def search_with_filter keyword, search_fields, membership, paymentstatus
    keywords = keyword.split(" ")
    puts keywords
    member = nil
    keywords.each do |word|
      query = ""
      query_keywords = {}
      counter = 65;
      search_fields.keys.each do |field|
        if Member.has_field?(field)
          query += (query.empty? ? "" : " OR ") + "#{field} LIKE :#{counter.chr}"
          query_keywords[counter.chr.to_sym] = "#{word}%"
          counter += 1
        end
      end
      member = (member ? member : Member).where(query, query_keywords)
    end
    if membership == "0" || membership == "1"
      puts !!membership
      member = (member ? member : Member).where(:membership => (membership == "0" ? false : true))
    end
    if paymentstatus == "0"
      puts !!membership
      member = (member ? member : Member).where("expirationdate < ?", Time.now)
    end
    if paymentstatus == "1"
      puts !!membership
      member = (member ? member : Member).where("expirationdate > ?", Time.now)
    end
    member || Member.all
  end

end
