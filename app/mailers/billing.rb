class Billing < ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => "587",
  :domain               => "gmail.com",
  :user_name            => "kantoliinatesti@gmail.com",
  :password             => "kant0liina",
  :authentication       => "plain",
  :enable_starttls_auto => true
  }

  def bill_email
    mail(:to => member.email, :subject => "Kantoliinayhdistyksen jäsenmaksu - lasku")
  end
end
