#encoding: utf-8
class Billing < ActionMailer::Base
  default :from => "kantoliinatest@gmail.com"

  def bill_email member, additional_message
    additional_message_split = additional_message.split(/^-+\s*$/)
    @top_additional_message = additional_message_split.at(0)
    @bottom_additional_message = additional_message_split.at(1)
    @member = member
    mail(:to => member.email, :subject => "Kantoliinayhdistyksen jäsenmaksu - lasku")
  end
end
