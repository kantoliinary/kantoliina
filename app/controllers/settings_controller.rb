class SettingsController < ApplicationController

  def index
    @error = flash[:error] || ""
    @template = flash[:template] || File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r') do |f|
      template = ""
      while line = f.gets
        template += line
      end
      template
    end
  end
end