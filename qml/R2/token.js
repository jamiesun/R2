WorkerScript.onMessage = function(message) {
    var auth = message.auth
    var sid = message.sid

    console.log("start tokening...")

    var http = new XMLHttpRequest()
    http.onreadystatechange = function() {
        if (http.readyState == XMLHttpRequest.DONE) {
            console.log("token result: "+ http.status+"  "+http.statusText);
            if(http.status==200){
                WorkerScript.sendMessage({msg:"sucess",token:http.responseText});
            }else{
                WorkerScript.sendMessage({msg:"error "+http.statusText})
            }
        }
    }

    http.open("GET", "https://www.google.com/reader/api/0/token")
    http.setRequestHeader("Authorization","GoogleLogin auth="+auth);
    http.setRequestHeader("Cookie","SID="+sid);
    http.send()


}








