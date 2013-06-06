class SettingsController < ApplicationController

  def index
    @template = ""
    File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r') do |f|
      while line = f.gets
        @template += line
      end
    end
  end
end