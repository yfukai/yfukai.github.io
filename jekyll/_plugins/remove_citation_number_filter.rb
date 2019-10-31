module Jekyll
  module StringFilter
    def remove_citaion_number(input)
        input.sub /\[\d*\]/, ""
    end
  end
end

Liquid::Template.register_filter(Jekyll::StringFilter)
