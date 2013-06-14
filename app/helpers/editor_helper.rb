#encoding: utf-8

module EditorHelper


  def self.index temp



    @template = temp || File.open(Rails.root.join("app", "views", "billing", "bill_email.html.haml").to_s, 'r') do |f|
      template = ""
      while line = f.gets
        template += line
      end
      template

    end
  end

  # @return [Object]


  def update
    return EditorHelper.update

  end

  def self.update template, file, f


    if EditorHelper.validate_invoice_template template, f
      File.open(file, 'w') do |f|
        f.puts template
      end
    end

  end

  def self.validate_invoice_template template, f


    deep = 0
    line_number = 1
    template.split(/\r?\n/).each do |row|
      unless row.strip.empty?
        unless row.match(/\A( {2}){0,1}\S{1}.*\z/)

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