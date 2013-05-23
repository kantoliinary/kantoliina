class MembersController < ApplicationController
  def new
     @member = flash[:member] || Member.new
  end

  def create

    @member = Member.new(params[:member])

    if @member.save
      flash[:notice] = "Jasen lisatty!"
    else
      flash[:member] = @member
    end
    redirect_to new_member_path
  end

  def index
    @members = Member.all
  end

end