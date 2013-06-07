##
# The controller for editing the invoice template

class SettingsController < ApplicationController


  ##
  # Loads the invoice template to the editor
  def index
    @error = flash[:error] || ""
    @errorline = flash[:errorline] || 0
    @template = flash[:template] || File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r') do |f|
      template = ""
      while line = f.gets
        template += line
      end
      template
    end
  end
end