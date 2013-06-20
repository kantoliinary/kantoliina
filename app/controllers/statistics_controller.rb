#encoding: utf-8
##
# The controller for the statistics page

class StatisticsController < ApplicationController

  ##
  # Initializes the statistics variables, calls the counting method and renders the statistics page

  def index
    @members = Member.includes(:membergroup)
    @active = 0
    @deleted = 0
    @membersdate
    @membergroups = Hash.new
    @municipalities = Hash.new
    count_stuff

    if params[:startdate]
      @membersdate = Member.where("created_at > :a AND created_at < :b AND active = 't'", :a => params[:startdate], :b=> params[:enddate])
    end

  end


  private
  ##
  # Counts the statistics shown in the statistics page
  def count_stuff
    @total = 0
    @members.each do |member|
      if member.active
        @active += 1
        if !member.membergroup.onetimefee
          @total += member.membergroup.fee
        end
        if @membergroups[member.membergroup.name.to_sym]
          @membergroups[member.membergroup.name.to_sym] =  @membergroups[member.membergroup.name.to_sym] + 1
        else
          @membergroups[member.membergroup.name.to_sym] = 1
        end

        if @municipalities[member.municipality.to_sym]
          @municipalities[member.municipality.to_sym] =  @municipalities[member.municipality.to_sym] + 1
        else
          @municipalities[member.municipality.to_sym] = 1
        end

      else
        @deleted += 1
      end

    end
     @municipalities = @municipalities.sort_by {|key,value| value}.reverse
    #@municipalities = Member.find_by_sql("SELECT municipality, counter FROM (SELECT municipality, count(*)
    #                  AS counter FROM members GROUP BY municipality) a ORDER BY counter desc").uniq
  end


end

