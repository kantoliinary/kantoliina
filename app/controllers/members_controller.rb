#encoding: utf-8
##
# The controller for class Member.

class MembersController < ApplicationController


  ##
  # Shows new member page to the admin.
  # If old member in flash[:member], saves it to @member.

  def new
    @member = flash[:member] || Member.new
    @member.membernumber = get_smallest_available_membernumber
    @member.paymentstatus = false
    @submit_text = "Lisää"
    @isnew = true
  end

  def get_smallest_available_membernumber
    members = Member.select(:membernumber).order(:membernumber)
    number = 10000

    members.each do |member|
      return number unless number == member.membernumber
      number+=1
    end
    return number
  end

  ##
  # Creates a new member with params[:member] and tries to save it.
  # If save succeeds, adds flash[:notice] message, otherwise adds members information to flash[:member].
  # Redirects to new member page.

  def create
    @member = Member.new(params[:member])
    #@member.membershipyear = (Time.now.year).to_i
    membernumber = @member.membernumber

    #Sets membership for next year
    if params[:nextyear]
      @member.membershipyear = (Time.now.year + 1).to_i
    else
      @member.membershipyear = (Time.now.year).to_i
    end

    if @member.save
      flash[:notice] = "Jäsen lisätty"
    else
      flash[:member] = @member
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
      if member
        member.paymentstatus = "#{!member.paymentstatus}"
        member.save!(:validate => false)
      end
    end
    flash[:notice] = "Maksustatus muutettu"
    redirect_to members_path
  end

  ##
  # Changes the deleted status and shows the changes on the screen.

  def delete

    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @members = Member.find_all_by_id(parsed_json["ids"])
    @members.each do |member|

      if member
        member.deleted = "#{!member.deleted}"
        member.save!(:validate => false)

      end
    end
    flash[:notice] = "Jäsen" + (@members.count > 1 ? "et" : "") +" poistettu"
    redirect_to members_path
  end

  ##
  # Lists all members to @members and shows the list page.

  def index
    @membergroups = Membergroup.all
    @deleted = params[:deleted] || "1"
    s_membergroups = params[:membergroups]
    @selected_membergroups = (s_membergroups ? s_membergroups.keys : nil) || @membergroups.collect { |g| "#{g.id}" }
  end

  def search
    @members = search_with_filters params[:keyword], params[:membergroups], params[:paymentstatus], params[:support], params[:lender], params[:deleted]
    respond_to do |format|
      format.json { render :json => @members }
    end
  end

  ##
  #Edits the current Member with right parameters.

  def edit
    @member = flash[:member] || Member.find(params[:id])
    @submit_text = "Tallenna muutokset"
  end

  ##
  #Replaces the selected attributes of a single member.
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


  private

##
# Filters members by selected radio buttons. Values are deleted and payment status with OR operation.
# If member has the field represented by the selected button, the subroutine searches for matching character combinations.


  def search_with_filters keyword, membergroups, paymentstatus, support, lender, deleted
    all_search_fields = ["firstnames", "surname", "municipality", "address", "zipcode", "postoffice", "membernumber"]

    keywords = (keyword ? keyword.split("|") : "")
    members = Member.includes(:membergroup)
    if keywords.length > 0
      keywords.each do |word|
        query = ""
        query_keywords = {}
        counter = 65;
        all_search_fields.each do |field|
          query += (query.empty? ? "" : " OR ") + "#{field} LIKE :#{counter.chr}"
          query_keywords[counter.chr.to_sym] = "#{word.strip}%"
          counter += 1
        end
        members = members.where(query, query_keywords)
      end
    end

    if deleted && deleted.length > 0
      members = members.where(:deleted => deleted.at(0) == "deleted[1]")
    end
    if paymentstatus && paymentstatus.length == 1
      members = members.where(:paymentstatus => paymentstatus.at(0) == "paymentstatus[1]")
      end
    if support && support.length == 1
      members = members.where(:support => support.at(0) == "support[1]")
      end
    if lender && lender.length == 1
      members = members.where(:lender => lender.at(0) == "lender[1]")
    end
    if membergroups && membergroups.length > 0
      query = ""
      query_keywords = {}
      counter = 65;
      membergroups.each do |id|
        query += (query.empty? ? "" : " OR ") + "membergroups.name = :#{counter.chr}"
        query_keywords[counter.chr.to_sym] = id
        counter += 1
      end
      members = members.joins(:membergroup).where(query, query_keywords)
    end
    members
  end

end
