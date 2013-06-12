#encoding: utf-8
class Billing < ActionMailer::Base
  default :from => "kantoliinatesti@gmail.com"

  def bill_email member, additional_message
    additional_message_split = additional_message.split(/^-+\s*$/)
    @top_additional_message = additional_message_split.at(0)
    @bottom_additional_message = additional_message_split.at(1)
    @member = member
    mail(:to => member.email, :subject => "Kantoliinayhdistyksen jäsenmaksu - lasku")
  end

<<<<<<< HEAD
  def reminder_email member, additional_message
    additional_message_split = additional_message.split(/^-+\s*$/)
    @top_additional_message = additional_message_split.at(0)
    @bottom_additional_message = additional_message_split.at(1)

=======
  def mailer member, message, subject
    @message2 = message
>>>>>>> 964266a900f71712322304a4b7ca49a036ab1d3b
    @member = member
    mail(:to => member.email, :subject => subject)
  end

  def reminder_email member
    @member = member
    mail(:to => member.email, :subject => "Kantoliinayhdistyksen jäsenmaksu - Maksumuistutus")
  end
end
