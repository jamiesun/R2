import Qt 4.7
import "../json2.js" as Json
ListModel{
    id:tagsModel
    property string auth:mainApp.auth
    property string sid:mainApp.sid
    property string source: "https://www.google.com/reader/api/0/tag/list?output=json"
    property bool busy: false
    property string cache_key: "tag_model"
    signal error(string error)

    function reload(){
        mainApp.setCache(cache_key,"")
        update()
    }

    function setData(result){
        tagsModel.clear()
        for(var i=0;i<result.length;i++){
            var tagid = result[i].id
            var tagname = tagid.substr(tagid.lastIndexOf('/')+1)
            tagsModel.append({tagname:tagname,tagid:tagid})
        }
        tagsModel.insert(1,{tagname:"notes",tagid:"user/-/state/com.google/created"})
    }

    function update(){
        var cacheData = mainApp.getCache(cache_key)
        if(cacheData){
            console.log("tag from cache")
            setData(JSON.parse(cacheData)['tags'])
            return
        }


        if(!sid||!auth){
            error("not login")
            return;
        }

        var http = new XMLHttpRequest();
        http.onreadystatechange = function() {
            if (http.readyState == XMLHttpRequest.DONE) {
                if(http.status==200){
                    setData(JSON.parse(http.responseText)['tags'])
                    mainApp.setCache(cache_key,http.responseText)
                } else{
                    error("tags update error")
                }
                tagsModel.busy = false
            }else{
                tagsModel.busy = true
            }
        }
        console.log("http GET "+source)
        http.open("GET", source);
        http.setRequestHeader("Authorization","GoogleLogin auth="+auth);
        http.setRequestHeader("Cookie","SID="+sid);
        http.setRequestHeader("accept-encoding", "gzip, deflate")
        http.send()
    }



}
