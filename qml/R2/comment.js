WorkerScript.onMessage = function(message) {
    console.log("sendmail action")

    var auth = message.auth
    var sid = message.sid
    var token = message.token
    var action = "addcomment"
    var streamId = message.streamId
    var comment = message.comment
    var id = message.id

    var params = "T="+token
                 +"&i="+id
                 +"&action=addcomment"
                 +"&s="+streamId
                 +"&comment="+comment

    console.log("start comment..."+params)

    var http = new XMLHttpRequest();
    http.onreadystatechange = function() {
        if (http.readyState == XMLHttpRequest.DONE) {
            console.log("comment result: "+ http.status+"  "+http.statusText);
            if(http.status==200){
               WorkerScript.sendMessage({code:0})
            }else if(http.status==401){
                console.log("401 error")
            } else{
                console.log("comment error")
            }
        }
    }
    var url = "https://www.google.com/reader/api/0/comment/edit?client=scroll"
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








