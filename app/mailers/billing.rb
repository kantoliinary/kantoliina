#encoding: utf-8
class Billing < ActionMailer::Base
  #default :from => "kantoliinatesti@gmail.com"

  def bill_email member, top_message, bottom_message
    @top_additional_message = top_message
    @bottom_additional_message = bottom_message
    @member = member
    mail(:to => member.email, :subject => "Kantoliinayhdistyksen jäsenmaksu - lasku")
  end

  def reminder_email member, top_message, bottom_message
    @top_additional_message = top_message
    @bottom_additional_message = bottom_message
    @member = member
    mail(:to => member.email, :subject => "Kantoliinayhdistyksen jäsenmaksu - Maksumuistutus")
  end


  def mailer member, message, subject, sender, filename, filepath

    @message2 = message
    @member = member
    if filepath
      attachments[filename] = File.read(filepath)
    end
    mail(:from => sender, :to => member.email, :subject => subject)
  end

end
