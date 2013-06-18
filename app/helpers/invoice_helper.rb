#encoding: utf-8

module InvoiceHelper

  def self.preview top, bottom, file

    template = ""
    @template = File.open(file, 'r') do |f|
      while line = f.gets
        template += line
      end
    end

    EditorHelper.preview template, Hash.new, top, bottom

  end
end