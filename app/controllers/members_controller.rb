class MembersController < ApplicationController
  before_filter :require_login

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

  def update
    @member = Member.find([:membernumber])
    if @member.as_null_object
      flash[:notice] = "Jasenta ei loydetty!"
    else
      @member.updated_at
    end
  end

  def index
    @members = Member.all
  end

  private

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end

  def logged_in?
    !!session[:admin]
  end
end