import Qt 4.7
import "../cache.js" as Cache
ListModel{
    id:rssModel
    property string sid:""
    property string auth:""
    property string tag:""
    property string source: "https://www.google.com/reader/api/0/subscription/list?output=json"
    property string contentSource: "https://www.google.com/reader/api/0/stream/contents/"

    property variant unreads: {}
    property bool busy: false
    property string cacheKey: "rssCache"
    signal error(string error)

    function getCount(id){
        if(!unreads)return 0
        var tmp = unreads[Qt.md5(id)]
        return tmp?parseInt(tmp):0
    }


    function filter(tag,unreads){
        rssModel.tag = tag
        rssModel.unreads = unreads
        var result = Cache.get(cacheKey)
        if(result){
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
                    if(categories[k].label==tag){
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

        //console.log("start update tags \n sid="+sid+"\n auth="+auth)
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
                    Cache.set(cacheKey,result)
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
        //console.log("auth string:"+authStr+"\n\n sid="+sid)
        try {
          console.log("http GET "+source)
          http.send();
        } catch (e) {
            console.log(e)
            error(e);
        }
    }



}
