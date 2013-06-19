#encoding: utf-8
##
# The controller for editing the invoice template

class StatisticsController < ApplicationController

  def index
    @members = Member.includes(:membergroup)
    @active = 0
    @deleted = 0
    @membergroups = Hash.new
    count_stuff

  end

  private

  def count_stuff
    @total = 0
    @members.each do |member|
      if member.active
        @total += member.membergroup.fee
        @active += 1
        if @membergroups[member.membergroup.name.to_sym]
          @membergroups[member.membergroup.name.to_sym] =  @membergroups[member.membergroup.name.to_sym] + 1
        else
          @membergroups[member.membergroup.name.to_sym] = 1
        end
      else
        @deleted += 1
      end
    end

    @municipalities = Member.find_by_sql("SELECT municipality, counter FROM (SELECT municipality, count(*)
                      AS counter FROM members GROUP BY municipality) a ORDER BY counter desc").uniq
  end


end

