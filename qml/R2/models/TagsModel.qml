import Qt 4.7
import "../json2.js" as Json
ListModel{
    id:tagsModel
    property string auth:mainApp.auth
    property string sid:mainApp.sid
    property string source: "https://www.google.com/reader/api/0/tag/list?output=json"
    property bool busy: false
    signal error(string error)

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
                    var result = JSON.parse(http.responseText)['tags']
                    tagsModel.clear()
                    for(var i=0;i<result.length;i++){
                        var tagid = result[i].id
                        var tagname = tagid.substr(tagid.lastIndexOf('/')+1)
                        tagsModel.append({tagname:tagname,tagid:tagid})
                    }
                    tagsModel.insert(1,{tagname:"notes",tagid:"user/-/state/com.google/created"})

                }else if(http.status==401){
                    error("401 error")
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
        try {
          http.send();
        } catch (e) {
            error(e);
        }
    }



}
