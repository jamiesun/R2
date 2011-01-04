import Qt 4.7
ListModel{
    id:rssModel
    property string sid:mainApp.sid
    property string auth:mainApp.auth
    property string tag:""
    property string source: "https://www.google.com/reader/api/0/subscription/list?output=json"
    property string contentSource: "https://www.google.com/reader/api/0/stream/contents/"
    property string cache_key: "rss_model"
    property variant cacheData: {}

    property variant unreads: {}
    property bool busy: false
    signal error(string error)

    function getCount(id){
        if(!unreads)return 0
        var tmp = unreads[Qt.md5(id)]
        return tmp?parseInt(tmp):0
    }


    function filter(tag,unreads){
        rssModel.tag = tag
        rssModel.unreads = unreads

        if(!cacheData)
            cacheData = mainApp.getCache(cache_key)

        if(cacheData){
            console.log("rss from cache")
            var result = JSON.parse(cacheData)['subscriptions']
            filter2(tag,result)
        }
        else{
            update()
        }
    }

    function filter2(tag,result){
        rssModel.clear()
        var counttotle = 0
        for(var i=0;i<result.length;i++){
            var rss = result[i]
            var categories = rss.categories
            if(categories&&categories.length>0){
                for(var k=0;k<categories.length;k++){
                    if(categories[k].id==tag){
                        var ct = getCount(rss.id)
                        rssModel.append({feedtitle:rss.title,feedid:contentSource+rss.id,count:ct})
                        counttotle += ct
                        break
                    }
                }
            }
        }
        rssModel.insert(0,{feedtitle:"All items",feedid:contentSource+tag,count:counttotle})
    }

    function update(){
        if(!sid||!auth){
            error("not login")
            return;
        }

        var http = new XMLHttpRequest();
        http.onreadystatechange = function() {
            if (http.readyState == XMLHttpRequest.DONE) {
                console.log("getFeeds:"+http.status+"  "+http.statusText);
                //console.log("resp:"+http.getAllResponseHeaders());
                if(http.status==200){
                    var result = JSON.parse(http.responseText)['subscriptions']
                    mainApp.setCache(cache_key,http.responseText)
                    filter2(rssModel.tag,result)
                }else if(http.status==401){
                    error("401 error")
                } else{
                    error("update error")
                }
                rssModel.busy = false
            }else{
                rssModel.busy = true
            }
        }
        http.open("GET", source);
        http.setRequestHeader("Authorization","GoogleLogin auth="+auth);
        http.setRequestHeader("Cookie","SID="+sid);
        http.setRequestHeader("accept-encoding", "gzip, deflate")
        http.send()
    }



}
