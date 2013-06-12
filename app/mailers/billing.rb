#encoding: utf-8
class Billing < ActionMailer::Base
  default :from => "kantoliinatesti@gmail.com"

  def bill_email member, top_message, bottom_message
    @top_additional_message = top_message
    @bottom_additional_message = bottom_message
    @member = member
    mail(:to => member.email, :subject => "Kantoliinayhdistyksen jäsenmaksu - lasku")
  end

  def mailer member, message, subject
    @message2 = message
    @member = member
    mail(:to => member.email, :subject => subject)
  end

  def reminder_email member
    @member = member
    mail(:to => member.email, :subject => "Kantoliinayhdistyksen jäsenmaksu - Maksumuistutus")
  end
end
