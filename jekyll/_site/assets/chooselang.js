function chooselang(){
    var lang = 'en';
    var valid_langs=['en','ja']
        var match = location.search.match(/lang=(.*?)(?:&|$)/);
    if(match) { 
        lang_tmp = decodeURIComponent(match[1]); 
        if($.inArray(lang_tmp,valid_langs) > -1){
            lang=lang_tmp;
        }
    }

    $("[class^=lang-]:not(.lang-"+lang+")").hide();
    $("a.lang").each(function(){
        var hrefs=$(this).attr("href").split("#");
        $(this).attr("href",hrefs[0]+"?lang="+lang+"#"+hrefs[1]);
    });
}
;
