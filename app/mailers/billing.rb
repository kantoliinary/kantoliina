#encoding: utf-8
class Billing < ActionMailer::Base
  @url  = "http://localhost:3000"
  def bill_email
    mail(:to => "kalle.lammenoja@gmail.com", :subject => "Kantoliinayhdistyksen jäsenmaksu - lasku")

  end
end
