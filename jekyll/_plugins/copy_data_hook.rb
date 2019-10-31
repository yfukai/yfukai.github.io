Jekyll::Hooks.register :site, :after_init do
    require 'fileutils'
    cwd=File.dirname(__FILE__)
    files=[
        ["../../../data/presentations/presentation.yaml", "../_data/"],
        ["../../../data/mypublications.bib", "../_bibliography/"],
    ]
    files.each do |file|
        FileUtils.cp File.join(cwd,file[0]), File.join(cwd,file[1])
    end
end
