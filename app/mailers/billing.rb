#encoding: utf-8
class Billing < ActionMailer::Base
  default :from => "kantoliinatest@gmail.com"

  def bill_email member
    mail(:to => member.email, :subject => "Kantoliinayhdistyksen jäsenmaksu - lasku")
  end
end
