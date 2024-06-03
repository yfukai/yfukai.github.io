Jekyll::Hooks.register :site, :pre_render do |site|
    puts "Generating collection from items"
    data = site.data['presentations']
    collection = Jekyll::Collection.new(site, 'presentations')
    data.each_with_index do |item, i|
      doc = Jekyll::Document.new(collection.directory, :site => site, :collection => collection)
      doc.data['name'] = item['title']
      doc.data['description'] = item['type']
      doc.data['slug'] = File.basename(i.to_s)
      collection.docs << doc
    end
    site.collections['presentations'] = collection
  end
  