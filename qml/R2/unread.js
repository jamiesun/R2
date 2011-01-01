WorkerScript.onMessage = function(message) {
    console.log("unread count stat")
    var auth = message.auth
    var sid = message.sid

    var http = new XMLHttpRequest();
    http.onreadystatechange = function() {
        if (http.readyState == XMLHttpRequest.DONE) {
            if(http.status==200){
               WorkerScript.sendMessage({unreads:http.responseText})
            }else if(http.status==401){
                console.log("401 error")
            } else{
                console.log("edit tag error")
            }
        }
    }
    var url = "https://www.google.com/reader/api/0/unread-count?allcomments=true&output=json&ck="+Number(new Date())+"&client=scroll"
    http.open("GET",url);
    http.setRequestHeader("Authorization","GoogleLogin auth="+auth);
    http.setRequestHeader("Cookie","SID="+sid);
    http.setRequestHeader("accept-encoding", "gzip, deflate")
    http.send()


}








