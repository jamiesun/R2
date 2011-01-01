WorkerScript.onMessage = function(message) {
    console.log("edittag action")
    var auth = message.auth
    var sid = message.sid
    var token = message.token
    var action = message.action?"a":"r"
    var option = message.option
    var entry = message.id
    var streamId = message.streamId



    var params = "T="+token+"&"+action+"="+"user/-/state/com.google/"+option+"&ac=edit-tags&i="+entry+"&s="+streamId

    console.log("start edittag..."+params)

    var http = new XMLHttpRequest();
    http.onreadystatechange = function() {
        if (http.readyState == XMLHttpRequest.DONE) {
            console.log("token result: "+ http.status+"  "+http.statusText);
            if(http.status==200){
               WorkerScript.sendMessage({code:0})
            }else if(http.status==401){
                console.log("401 error")
            } else{
                console.log("edit tag error")
            }
        }
    }
    var url = "https://www.google.com/reader/api/0/edit-tag?client=scroll"
    http.open("POST",url);
    http.setRequestHeader("Authorization","GoogleLogin auth="+auth);
    http.setRequestHeader("Cookie","SID="+sid);
    http.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    http.setRequestHeader("Content-Length", params.length);
    http.send(params)


}








