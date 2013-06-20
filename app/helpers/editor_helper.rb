#encoding: utf-8
##
# The helper for the reminder and invoice editors
module EditorHelper

  ##
  #params:
  # +function+:: The parameter for selecting between the save and preview functions
  # template The edited template that is validated for preview or save
  # file The file where the template is to be saved
  # f The flash for the validation errors
  # Validates and saves a template or previews it
  #@return The flash where the error messages are located

  def self.update function, template, file, f

    if function == "preview"
      EditorHelper.preview template, f, "Yläosan viesti", "Alaosan viesti"
    end


    if function == "save"
      if EditorHelper.validate_invoice_template template, f
        File.open(file, 'w') do |f|
          f.puts template
        end
      end
    end
  end



  ##
  # Validates the preview and renders it to a flash object
  def self.preview template, f, top, bottom

    if EditorHelper.validate_invoice_template template, f
      member = Member.new
      member.membernumber = 90000
      member.invoicedate = Time.now
      member.membergroup_id = 1
      #top_additional_message = top
      #bottom_additional_message = bottom


      f[:template] = template
      engine = Haml::Engine.new(template.gsub(/[@]/, ''))
      f[:preview] = engine.render(Object.new, :member => member, :top_additional_message => top, :bottom_additional_message => bottom)
    end

  end

  ##
  # Gets a file as a parameter and renders it to a flash object
  def self.load_default file, f

    template = ''

    File.open(file, 'r') do |a|
      while (line = a.gets)
        template += line
      end
      f[:template] = template
    end
  end

  ##
  # Validates a template and renders the possible errors in a flash object
  def self.validate_invoice_template template, f


    deep = 0
    line_number = 1
    template.split(/\r?\n/).each do |row|
      unless row.strip.empty?
        unless row.match(/\A( {2}){0,#{deep}}\S{1}.*\z/)

          f[:error] = "Virheellinen sisennys rivillä #{line_number}: #{row}"
          f[:template] = template
          f[:errorline] = line_number
          return false
        end
        deep = row.index(/\S{1}/)
        if row.match(/\A\s*%.*\z/)
          deep += 2
        end
      end
      line_number += 1
    end
    f[:notice] = "Muutokset Tallennettu"
    true
  end

end