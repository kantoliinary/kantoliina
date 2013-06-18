#encoding: utf-8

module InvoiceHelper

  def self.preview top, bottom, type

    template = ""
    if type
      @template = File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r') do |f|
        while line = f.gets
          template += line
        end
        template
      end
    else
      @template = File.open(Rails.root.join("app", "views", "billing", "reminder_email.html.haml").to_s, 'r') do |f|
        while line = f.gets
          template += line
        end
        template
      end
    end

    EditorHelper.preview template, Hash.new, top, bottom

  end
end