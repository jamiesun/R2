WorkerScript.onMessage = function(message) {
    console.log("comment action")
    var auth = message.auth
    var sid = message.sid
    var token = message.token
    var snippet = message.snippet
    var annotation = message.comment
    var srcTitle = message.srcTitle
    var srcUrl = message.srcUrl
    var title = message.title
    var url = message.url

    var params = "T="+token+"&linkify=false&share=true"
                 + "&annotation="+encodeURIComponent(annotation)
                 + "&snippet="+encodeURIComponent(snippet)
                 + "&srcTitle="+encodeURIComponent(srcTitle)
                 + "&srcUrl="+encodeURIComponent(srcUrl)
                 + "&title="+encodeURIComponent(title)
                 + "&url="+encodeURIComponent(url)


    var http = new XMLHttpRequest();
    http.onreadystatechange = function() {
        if (http.readyState == XMLHttpRequest.DONE) {
//            console.log("comment result: "+ http.status+"  "+http.statusText);
//            console.log("resp:"+http.getAllResponseHeaders());
//            console.log(http.responseText)
            if(http.status==200){
                WorkerScript.sendMessage({code:0,msg:"sucess"})
            } else{
                WorkerScript.sendMessage({code:0,msg:"error "+http.statusText})
            }
        }
    }
    var url = "https://www.google.com/reader/api/0/item/edit?ck="+Number(new Date())+"&client=link-bookmarklet-form"
    http.open("POST",url);
    http.setRequestHeader("Authorization","GoogleLogin auth="+auth);
    http.setRequestHeader("Cookie","SID="+sid);
    http.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    http.setRequestHeader("Content-Length", params.length);
    http.send(params);


}








