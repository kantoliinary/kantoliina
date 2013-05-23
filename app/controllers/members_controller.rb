class MembersController < ApplicationController
  def new

  end

  def create
    flash[:notice] = "Jasen lisatty!"
    Member.create!(params[:member])


    redirect_to new_member_path
  end

end