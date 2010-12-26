WorkerScript.onMessage = function(message) {
    var email = message.email;
    var passwd = message.passwd;
    var auth,sid

    console.log("start clientLogin...");
    var auth_params = "accountType=HOSTED_OR_GOOGLE&Email="+email+"&Passwd="+passwd+"&service=reader&source=J-MyReader-1.0";
    var http = new XMLHttpRequest()
    http.onreadystatechange = function() {
        if (http.readyState == XMLHttpRequest.DONE) {
            console.log("auth result: "+ http.status+"  "+http.statusText);
            if(http.status==200){
                //console.log("resp:"+http.getAllResponseHeaders());
                var arrs = http.responseText.split('\n')
                for(var idx in arrs){
                    var arr = arrs[idx]
                    //console.log(arr+"\n\n");
                    var tmp = arr.split('=');
                    if(tmp[0]=="Auth"){
                        auth = tmp[1];
                    }else if(tmp[0]=="SID"){
                        sid = tmp[1];
                    }
                    if(auth&&sid)
                        WorkerScript.sendMessage({auth:auth,sid:sid});
                }
            }
        }
    }
    http.open("POST", "https://www.google.com/accounts/ClientLogin");
    http.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    http.setRequestHeader("Content-Length", auth_params.length);


    try {
      console.log("http auth send")
      http.send( auth_params );
    } catch (e) {
        console.log(e)
    }


}








