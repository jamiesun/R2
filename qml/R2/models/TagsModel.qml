import Qt 4.7
import "../json2.js" as Json
ListModel{
    id:tagsModel
    property string sid:""
    property string auth:""
    property string source: "http://www.google.com/reader/api/0/tag/list?output=json"
    property bool busy: false
    signal error(string error)

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
                    var result = JSON.parse(http.responseText)['tags']
                    tagsModel.clear()
                    for(var i=0;i<result.length;i++){
                        var tagname = result[i].id
                        tagname = tagname.substr(tagname.lastIndexOf('/')+1)
                        tagsModel.append({tagname:tagname})
                    }

                }else if(http.status==401){
                    error("401 error")
                } else{
                    error("update error")
                }
                tagsModel.busy = false
            }else{
                tagsModel.busy = true
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
