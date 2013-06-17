#encoding: utf-8
##
# The controller for class Member.

class RandomController < ApplicationController

  def new
  end


  def random
    puts 'aaaaaa'
    parsed_json = ActiveSupport::JSON.decode(params[:ids])
    @members = Member.find_all_by_id(parsed_json["ids"])
    @members = [@members[rand(@members.length)]]
    puts @members
    redirect_to random_path
  end
end
