#encoding: utf-8
##
# The controller for class Member.

class MembersController < ApplicationController


  ##
  # Shows a new member page to the admin.
  # If an old member is in flash[:member], saves it to @member.

  def new
    @member = flash[:member] || Member.new
    @member.membernumber = get_smallest_available_membernumber
    @submit_text = "Lisää"
    @isnew = true
    @checked_invoice = flash[:sendinvoice] || false
    @checked_nextyear = flash[:nextyear] || false
  end


  ##
  # Finds the smallest available member number for a me
  def get_smallest_available_membernumber
    members = Member.select(:membernumber).order(:membernumber)
    number = 10000

    members.each do |member|
      return number unless number == member.membernumber.to_i
      number+=1
    end
    return number
  end


  ##
  # Creates a new member with params[:member] and tries to save it.
  # If save succeeds, adds flash[:notice] message, otherwise adds members information to flash[:member].
  # Redirects to new member page.

  def create

    flash[:sendinvoice] = !!params[:sendinvoice]
    flash[:nextyear] = !!params[:nextyear]

    @member = Member.new(params[:member])
    #@member.membershipyear = (Time.now.year).to_i
    membernumber = @member.membernumber

    @other = Member.where(:firstnames => @member.firstnames, :surname => @member.surname, :address => @member.address, :zipcode => @member.zipcode, :municipality => @member.municipality)

    if !@other.empty?
      flash[:error] = "Jäsen samoilla nimi- ja osoitetiedoilla on jo olemassa"
      redirect_to new_member_path and return
    end

    if @member.paymentstatus
      @member.membershipyear = (Time.now.year).to_i
    else
      @member.membershipyear = (Time.now.year - 1).to_i
    end

    if params[:nextyear]
      @member.membershipyear = (Time.now.year + 1).to_i
    end

    if @member.save
      flash[:notice] = "Jäsen lisätty"
    else
      flash[:member] = @member
      redirect_to new_member_path and return
    end

    member = Member.find_by_membernumber(membernumber)
    if params[:sendinvoice]
      redirect_to invoice_confirm_path(:id => member.id)
    else
      redirect_to new_member_path
    end
  end

  ##
  # Parses an array of IDs from JSON code given as a parameter and selects an array of members based on those IDs.
  # Deletes/Activates selected members.
  #
  # Redirects to the list page.

  def payment
    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @members = Member.find_all_by_id(parsed_json["ids"])
    @members.each do |member|
      if member.paymentstatus == false
        member.paymentstatus = true
        member.paymentdate = Time.now
        if member.membershipyear.to_i < (Time.now.year).to_i
          member.membershipyear = (Time.now.year).to_i
        end
        member.save!(:validate => false)
        flash[:notice] = "Maksustatus muutettu maksaneeksi"
      else
        flash[:error] = "Jäsen on jo maksanut"
      end
    end
    redirect_to members_path
  end

  ##
  #

  def unpayment
    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @members = Member.find_all_by_id(parsed_json["ids"])
    @members = Member.find_all_by_id(parsed_json["ids"])
    @members.each do |member|
      if member.paymentstatus == true
        member.paymentstatus = false
        member.save!(:validate => false)
        flash[:notice] = "Maksustatus muutettu maksamattomaksi"
      else
        flash[:error] = "Jäsen on jo maksamaton"
      end
    end
    redirect_to members_path
  end

  ##
  # Changes the active status and shows the changes on the screen.

  def delete

    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @members = Member.find_all_by_id(parsed_json["ids"])
    @members.each do |member|

      if member
        member.active = "#{!member.active}"
        member.save!(:validate => false)

      end
    end
    flash[:notice] = "Jäsen" + (@members.count > 1 ? "et" : "") +" poistettu"
    redirect_to members_path
  end

  ##
  # Lists all members to @members and shows the list page.

  def index
    require 'csv'

    @members = Member.order(:id)

    respond_to do |format|
      format.html
      format.csv { send_data @members.as_csv }

      @membergroups = Membergroup.all
      @active = params[:active] || "1"
      s_membergroups = params[:membergroups]
      @municipalitys = Member.find_by_sql("SELECT municipality, counter FROM (SELECT municipality, count(*)
                        AS counter FROM members GROUP BY municipality) a ORDER BY counter desc").uniq
      @selected_membergroups = (s_membergroups ? s_membergroups.keys : nil) || @membergroups.collect { |g| "#{g.id}" }
    end
  end

  ##
  # Gets a file as a parameter, sends the file to the model and sets notices and errors
  def import
    if (params[:file])

      flash[:notice] = Member.import(params[:file])
    else
      flash[:error] = "Valitse ensin tiedosto"
    end

    redirect_to members_path
  end


  ##
  # Searches members by given parameters and updates the main page
  def search
    @members = search_with_filters params
    respond_to do |format|
      format.json { render :json => @members }
    end
  end

  ##
  # Edits the current Member with right parameters.

  def edit
    @member = flash[:member] || Member.find(params[:id])
    @submit_text = "Tallenna muutokset"
  end

  ##
  # Replaces the selected attributes of a single member.
  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(params[:member])
      flash[:notice] = "Tiedot muutettu"
    else
      flash[:member] = @member
      redirect_to edit_member_path @member and return
    end
    redirect_to members_path
  end

  ##
  # Finds the address data of selected members and forwards them to the address data page
  def addressdata
    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @members = Member.find_all_by_id(parsed_json["ids"], :joins => [:membergroup])
    render :layout => false
  end

  private

  ##
  # Filters members by selected radio buttons. Values are active and payment status with OR operation.
  # If member has the field represented by the selected button, the subroutine searches for matching character combinations.
  def search_with_filters filters
    all_search_fields = ["firstnames", "surname", "email", "municipality", "address", "zipcode", "postoffice", "membernumber", "country", "membershipyear"]
    keywords = (filters[:keyword] ? filters[:keyword].split("|") : "")
    members = Member.includes(:membergroup)
    if keywords.length > 0
      keywords.each do |word|
        query = ""
        query_keywords = {}
        counter = 65;
        amount = 1
        all_search_fields.each do |field|
          i = 0
          symbol = ""
          while i < amount
            symbol += counter.chr
            i += 1
          end
          query += (query.empty? ? "" : " OR ") + "LOWER(#{field}) LIKE :#{symbol}"
          query_keywords[symbol.to_sym] = "#{word.strip.downcase}%"
          counter += 1
          if counter > 90
            amount += 1
            counter = 65
          end
        end
        query += " OR LOWER(membergroups.name) LIKE :membergroup"
        query_keywords[:membergroup] = "#{word.strip.downcase}%"
        members = members.where(query, query_keywords)
      end

    end

    members = members.where(:active => !filters[:active])

    if filters[:paymentstatus] && filters[:paymentstatus].length == 1
      members = members.where(:paymentstatus => filters[:paymentstatus].at(0) == "1")
    end
    if filters[:support] && filters[:support].length == 1
      members = members.where(:support => filters[:support].at(0) == "1")
    end
    if filters[:lender] && filters[:lender].length == 1
      members = members.where(:lender => filters[:lender].at(0) == "1")
    end
    if filters[:membergroups]
      query = ""
      query_keywords = {}
      counter = 65;
      amount = 1
      filters[:membergroups].each do |id|
        i = 0
        symbol = ""
        while i < amount
          symbol += counter.chr
          i += 1
        end
        query += (query.empty? ? "" : " OR ") + "membergroup_id = :#{symbol}"
        query_keywords[symbol.to_sym] = id
        counter += 1
        if counter > 90
          amount += 1
          counter = 65
        end
      end
      members = members.where(query, query_keywords)
    end
    if filters[:municipalitys]
      query = ""
      query_keywords = {}
      counter = 65;
      amount = 1
      filters[:municipalitys].each do |municipality|
        i = 0
        symbol = ""
        while i < amount
          symbol += counter.chr
          i += 1
        end
        query += (query.empty? ? "" : " OR ") + "municipality = :#{symbol}"
        query_keywords[symbol.to_sym] = municipality
        counter += 1
        if counter > 90
          amount += 1
          counter = 65
        end
      end
      members = members.where(query, query_keywords).order(:membernumber)
    end
    members
  end
end
