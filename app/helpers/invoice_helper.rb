#encoding: utf-8

module InvoiceHelper

  def self.preview top, bottom

    template = ""
    @template = File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r') do |f|
      while line = f.gets
        template += line
      end
      template
    end

    EditorHelper.preview template, Hash.new, top, bottom

  end
end