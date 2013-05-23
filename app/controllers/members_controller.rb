class MembersController < ApplicationController
  def new
     @member = Member.new
  end

  def create

    flash[:notice] = "Jasen lisatty!"
    @member = Member.create!(params[:member])


    redirect_to new_member_path
  end

end