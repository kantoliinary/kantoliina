class AdminsController < ApplicationController
  def loginform
    @error = Hash.new
  end
  def login
    user = Admin.find_by_login(params[:login]).try(:authenticate, params[:password])
    @error = Hash.new
    if  user
      session[:id] = user.id
      flash[:notice] = "Kirjauduttu"
      redirect_to login_path and return
    end
    @error[:error] = "Virheellinen kayttajatunnus tai salasana"
    render "loginform"
  end
end