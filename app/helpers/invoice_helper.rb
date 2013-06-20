#encoding: utf-8
##
# The helper for the invoice and reminder confirmation pages
module InvoiceHelper

  ##
  # Creates a template from a parameter file and gives it to a preview subroutine
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