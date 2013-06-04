class AdminMailer < ActionMailer::Base
  default :from => "kantoliinatesti@gmail.com"

  def password_reset admin, new_password
    @new_password = new_password
    mail :to => admin.email, :subjest => "Salasanan palautus"
  end
end