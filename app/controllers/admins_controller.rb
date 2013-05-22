class AdminsController < ApplicationController
  def loginform
    @error = Hash.new
  end
  def login
    member = Admin.find_by_login(params[:login]).try(:authenticate, params[:password])
    @error = Hash.new
    if  member
      session[:id] = member.id
      flash[:notice] = "Kirjauduttu"
      redirect_to new_member_path and return
    end
    @error[:error] = "Virheellinen kayttajatunnus tai salasana"
    render "loginform"
  end
  def logout
    reset_session
    flash[:notice] = "Kirjauduttu ulos"
    redirect_to login_path
  end
end