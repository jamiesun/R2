WorkerScript.onMessage = function(message) {
    console.log("new note action")

    if(!message.snippet) return

    var auth = message.auth
    var sid = message.sid
    var token = message.token
    var tags = message.tags?message.tags.split(','):[]
    var snippet = message.snippet
    var title = snippet.length>32?snippet.substr(0,32)+"...":snippet


    var params = "T="+token+"&linkify=true&share=true"
                 + "&snippet="+encodeURIComponent(snippet)
                 + "&title="+encodeURIComponent(title)

    for(var ik in tags) params += "&tags=user/-/label/"+tags[ik]

    console.log("start new note..."+params)


    var http = new XMLHttpRequest();
    http.onreadystatechange = function() {
        if (http.readyState == XMLHttpRequest.DONE) {
            if(http.status==200){
                WorkerScript.sendMessage({code:0,msg:"sucess"})
            }else{
                WorkerScript.sendMessage({code:http.status,msg:"error "+http.statusText})
            }
        }
    }
    var url = "https://www.google.com/reader/api/0/item/edit?ck="+Number(new Date())+"&client=scroll"
    http.open("POST",url);
    http.setRequestHeader("Authorization","GoogleLogin auth="+auth);
    http.setRequestHeader("Cookie","SID="+sid);
    http.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    http.setRequestHeader("Content-Length", params.length);
    try {
      console.log(url+"&"+params)
      http.send(params);
    } catch (e) {
        console.log(e)
        error(e);
    }


}








