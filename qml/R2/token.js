WorkerScript.onMessage = function(message) {
    var auth = message.auth
    var sid = message.sid;

    console.log("start tokening...");

    var http = new XMLHttpRequest();
    http.onreadystatechange = function() {
        if (http.readyState == XMLHttpRequest.DONE) {
            console.log("token result: "+ http.status+"  "+http.statusText);
            //console.log("resp:"+http.getAllResponseHeaders());
            if(http.status==200){
                 WorkerScript.sendMessage({token:http.responseText});
            }else if(http.status==401){
                console.log("401 error")
            } else{
                console.log("getToken error")
            }
        }
    }
    var url = "https://www.google.com/reader/api/0/token?client=scroll&ck="+Number(new Date());
    http.open("GET", url);
    http.setRequestHeader("Authorization","GoogleLogin auth="+auth);
    http.setRequestHeader("Cookie","SID="+sid);
    http.setRequestHeader("accept-encoding", "gzip, deflate")
    try {
      console.log(url)
      http.send();
    } catch (e) {
        console.log(e)
        error(e);
    }


}








