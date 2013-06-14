#encoding: utf-8
##
# The controller for editing the invoice template

class SettingsController < ApplicationController


  def index

  end


  def load_default
    template = ""


    File.open(Rails.root.join("app", "views", "billing", "default_bill.html.haml").to_s, 'r') do |f|
      while line = f.gets
        template += line
      end
    end

    flash[:template] = template

    redirect_to settings_path


  end
end