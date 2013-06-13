#encoding: utf-8
##
# The controller for editing the invoice template

class SettingsController < ApplicationController

  ##
  # Renders page
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

  private

  ##
  # Checks that there are no invalid changes made to the invoice template

  def validate_invoice_template template
    deep = 0
    line_number = 1
    template.split(/\r?\n/).each do |row|
      unless row.strip.empty?
        unless row.match(/\A[ ]{0,#{deep}}\S{1}.*\z/)
          flash[:error] = "Virheellinen sisennys rivillä #{line_number}: #{row}"
          flash[:template] = template
          flash[:errorline] = line_number
          return false
        end
        deep = row.index(/\S{1}/)
        if row.match(/\A\s*%.*\z/)
          deep += 2
        end
      end
      line_number += 1
    end
    flash[:notice] = "Muutokset Tallennettu"
    true
  end
end