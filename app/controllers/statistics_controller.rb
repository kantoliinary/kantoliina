#encoding: utf-8
##
# The controller for editing the invoice template

class StatisticsController < ApplicationController

  def count_fees
    members = Member.all.include(:membergroup)
    @total = 0
    members do |member|
      @total =+ member.fee
    end
  end

end

