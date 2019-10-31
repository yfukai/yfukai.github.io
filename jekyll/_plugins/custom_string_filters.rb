module Jekyll
  module StringFilter
    def remove_citaion_number(input)
        input.sub /\[\d*\]/, ""
    end
    def add_tag(input,tag)
        "<"+tag+">" + input + "</"+tag+">"
    end
    def format_author(names,presentor_id)
        names[presentor_id-1]=add_tag(names[presentor_id-1],"u")
        if names.length == 1
            return names[0]
        else
            names_last=names.pop()
            return names.join(", ")+" and "+names_last
        end
    end
    def format_pdf(entry)
        name="/pdf/"+entry["year"]+"-"+entry["title"]+".pdf" 
        return name.gsub /\s/, "_"
    end
    def if_exists(input,default_value)
        if input.nil?
            return default_value
        else
            return input
        end
    end
  end
end

Liquid::Template.register_filter(Jekyll::StringFilter)
