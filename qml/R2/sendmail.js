WorkerScript.onMessage = function(message) {
    console.log("sendmail action")

    var auth = message.auth
    var sid = message.sid
    var token = message.token
    var emailTo = message.emailTo
    var subject = message.subject
    var comment = message.comment
    var id = message.id

    if(!emailTo)return

    var params = "T="+token
                 +"&i="+id
                 +"&emailTo="+emailTo
                 +"&subject="+encodeURIComponent(subject)
                 +"&comment="+encodeURIComponent(comment)


    var http = new XMLHttpRequest();
    http.onreadystatechange = function() {
        if (http.readyState == XMLHttpRequest.DONE) {
            if(http.status==200){
                WorkerScript.sendMessage({code:0,msg:"sucess"})
            }else{
                WorkerScript.sendMessage({code:0,msg:"error "+http.statusText})
            }
        }
    }
    var url = "https://www.google.com/reader/email-this?ck="+Number(new Date())+"&client=scroll"
    http.open("POST",url);
    http.setRequestHeader("Authorization","GoogleLogin auth="+auth);
    http.setRequestHeader("Cookie","SID="+sid);
    http.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    http.setRequestHeader("Content-Length", params.length);
    http.send(params)

}








