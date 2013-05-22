class MembersController < ApplicationController
  def new

  end

  def create
    flash[:notice] = "Jasen lisatty!"
    redirect_to new_member_path
  end

end