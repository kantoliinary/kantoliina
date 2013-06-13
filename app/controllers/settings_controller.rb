#encoding: utf-8
##
# The controller for editing the invoice template

class SettingsController < ApplicationController


  ##
  # Loads the invoice template to the editor
  def index


    @error = flash[:error] || ""
    @errorline = flash[:errorline] || 0

    unless (params[:temp] == "2")
      @template = flash[:template] || File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r') do |f|
        template = ""
        while line = f.gets
          template += line
        end
        template
      end

    else
      @template = flash[:template] || File.open(Rails.root.join("app", "views", "billing", "reminder_email.html.haml").to_s, 'r') do |f|
        template = ""
        while line = f.gets
          template += line
        end
        template
      end
    end

  end

  ##
  # Loads the invoice template to the interface

  def update

    unless (params[:temp] == "2")
      template = params[:template]
      if validate_invoice_template template
        File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'w') do |f|
          f.puts template
        end
      end
      redirect_to settings_path

    else
      template = params[:template]
      if validate_invoice_template template
        File.open(Rails.root.join("app", "views", "billing", "reminder_email.html.haml").to_s, 'w') do |f|
          f.puts template
        end
      end
      redirect_to settings_path(:temp => 2)
    end
  end

  def load_default
    #unless (params[:temp] == "2")
    template = ""
    File.open(Rails.root.join("app", "views", "billing", "default_bill.html.haml").to_s, 'r') do |f|
      while line = f.gets
        template += line
      end
    end

    flash[:template] = template

  redirect_to settings_path
  end
  #else
  #  template = params[:template]
  #  if validate_invoice_template template
  #    File.open(Rails.root.join("app", "views", "billing", "reminder_email.html.haml").to_s, 'w') do |f|
  #      f.puts template
  #    end
  #  end
  #  redirect_to settings_path(:temp => 2)
  #end


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