import Qt 4.7
import "../cache.js" as Cache
ListModel {
    id:feedModel
    property string sid:""
    property string auth:""
    property string title:""
    property string feedUrl:""
    property string feedMax: "30"

    property bool busy: false
    signal error(string error)
    signal doContinuation(string c)

    function setData(result){
        feedModel.title = result.title
        var items = result.items
        feedModel.clear()
        for(var i=0;i<items.length;i++){
            var ititle = items[i].title
            var content = ""
            var summary = items[i].summary
            var icontent = items[i].content
            var itemid = items[i].id
            var istreamId = items[i].origin.streamId
            if(icontent){
                content = icontent.content
            }else{
                content = summary.content
            }

            var isRead = false
            var isShare = false
            var isStar = false
            var isLike = false
            var categories = items[i].categories
            for(var k=0;k<categories.length;k++){
                if(categories[k].search("read$")!=-1){
                    isRead = true
                }
                if(categories[k].search("like$")!=-1){
                    isLike = true
                }
                if(categories[k].search("starred$")!=-1){
                    isStar = true
                }
                if(categories[k].search("broadcast$")!=-1){
                    isShare = true
                }
            }
            var mobj = {}
            mobj.auth = auth
            mobj.sid = sid
            mobj.title = ititle
            mobj.content = content
            mobj.id = itemid
            mobj.streamId = istreamId
            mobj.isRead = isRead
            mobj.isLike = isLike
            mobj.isStar = isStar
            mobj.isShare = isShare
            feedModel.append(mobj)
        }
    }

    function reload(){
        Cache.set(feedModel.feedUrl,{})
        update(feedModel.feedUrl)
    }

    function update(feedUrl){
        console.log("update feed"+feedUrl)
        feedModel.feedUrl = feedUrl

        if(!sid||!auth){
            error("not login")
            return;
        }

        var result = Cache.get(feedUrl)

        if(result&&result.length>0){
            setData(result)
            return
        }

        var http = new XMLHttpRequest();
        http.onreadystatechange = function() {
            if (http.readyState == XMLHttpRequest.DONE) {
                if(http.status==200){
                    var result = JSON.parse(http.responseText)
                    Cache.set(feedUrl,result)
                    setData(result)
                }else if(http.status==401){
                    error("401 error")
                } else{
                    error("update error")
                }
                feedModel.busy = false
            }else{
                feedModel.busy = true
            }
        }

        http.open("GET", feedUrl+"?n="+feedMax);
        http.setRequestHeader("Authorization","GoogleLogin auth="+auth);
        http.setRequestHeader("Cookie","SID="+sid);
        http.setRequestHeader("accept-encoding", "gzip, deflate")
        try {
          console.log("http GET "+feedUrl)
          http.send();
        } catch (e) {
            console.log(e)
            error(e);
        }
    }

}
