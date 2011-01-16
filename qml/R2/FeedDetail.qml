import Qt 4.7
import QtWebKit 1.0
Flickable {
    property bool hide: true
    property variant currentObj: {}
    id: flickable
    width: parent.width
    contentWidth: Math.max(parent.width,web_view.width)
    contentHeight: Math.max(parent.height,web_view.height)
    boundsBehavior: "StopAtBounds"
    pressDelay: 200
    smooth: true

    Behavior on contentX{NumberAnimation{duration: 600;easing.type: Easing.InOutQuart}}
    Behavior on contentY{NumberAnimation{duration: 600;easing.type: Easing.InOutQuart}}

    signal next()
    signal previous()
    signal back()
    signal home()
    signal sendmail()
    signal doComment()
    signal modelChanged(variant obj)
    signal notice(string msg)
    signal needLogin()

    function chkLogin(){
        if(!mainApp.auth||!mainApp.sid||!mainApp.token){
            needLogin()
            return false
        }
        return true
    }

    WorkerScript {
        id: actionWork
        source: "edittag.js"
        onMessage: {
            if(messageObject.code==401){
                needLogin()
            }
        }
    }

    Keys.onSelectPressed:{
        feedMenu.show()
    }

    Keys.onPressed:{
        if(event.key == '17825793'){
            feedMenu.hide()
            back()
        }
        if(event.key == '17825792'){
            feedMenu.hide()
            home()
        }
    }

    function copyObj(obj,dest){
        for(var k in obj){
            dest[k] = obj[k]
        }
    }


    function update(mobj){
        if(!mobj)return
        currentObj = mobj
        if(!currentObj.isRead&&mainApp.isLogin()){
            var msg = {action:true,option:"read"}
            copyObj(currentObj,msg)
            actionWork.sendMessage(msg)
            currentObj.isRead = true
            modelChanged(currentObj)
        }

        var re = /<IMG(.*?)src=\"*(.*?)\"*(\s|>)/gi
        var ms
        var ncontent = mobj.content
        while ((ms = re.exec(mobj.content)))  {
            var ourl = ms[2]
            var nurl = mainApp.getImagePath(ourl)
            ncontent = ncontent.replace(ourl,nurl)
        }

        web_view.html = "<style> body{background:white;font-size：12px;} img{max-width:"+(flickable.parent.width-20)+"px;height:auto;} </style>"
                  + "<h3>"+currentObj.title+"</h3>"
                  + ncontent
        web_view.forceActiveFocus()
        contentX = 0
        contentY = 0
    }



    property int histx : 0
    property int histy : 0

    function resetPos(){
        feedMenu.x += contentX-histx
        feedMenu.y += contentY-histy
        loading.x += contentX-histx
        loading.y += contentY-histy
        histx = contentX
        histy = contentY
    }
    onContentXChanged: resetPos()
    onContentYChanged: resetPos()


    onFocusChanged: {
        if(activeFocus){
            web_view.forceActiveFocus()
        }

    }

    WebView {
        id: web_view
        x: 0;y: 0
        opacity:  hide?0.0:1.0
        clip: true;smooth:true
        preferredWidth: flickable.width
        preferredHeight: flickable.height
        Behavior on opacity{NumberAnimation{duration:200}}

        Keys.onUpPressed:{
            if(!flickable.atYBeginning)
                flickable.contentY -= Math.min(flickable.parent.height/2,Math.abs(flickable.contentY));
        }
        Keys.onDownPressed:{
            if(!flickable.atYEnd)
                flickable.contentY += Math.min(flickable.parent.height/2,Math.abs(flickable.parent.height-(flickable.contentHeight-contentY)));
        }

        Keys.onLeftPressed:{
            flickable.previous()
        }
        Keys.onRightPressed:{
            flickable.next()
        }

    }


    FeedMenu{
        id:feedMenu
        opacity: 0
        x:(flickable.parent.width - feedMenu.width)/2
        y:(flickable.parent.height - feedMenu.height)/2
        isShare: currentObj?currentObj.isShare:false
        isStar: currentObj?currentObj.isStar:false
        isLike: currentObj?currentObj.isLike:false

        onClose: {
            feedMenu.hide()
            flickable.forceActiveFocus()
        }

        onShare:{
            if(!chkLogin)return
            var msg = {action:!currentObj.isShare,option:"broadcast"}
            copyObj(currentObj,msg)
            actionWork.sendMessage(msg)
            currentObj.isShare = !currentObj.isShare
            modelChanged(currentObj)
        }
        onStar:{
            if(!chkLogin)return
            var msg = {action:!currentObj.isStar,option:"starred"}
            copyObj(currentObj,msg)
            actionWork.sendMessage(msg)
            currentObj.isStar = !currentObj.isStar
            modelChanged(currentObj)
        }

        onLike:{
            if(!chkLogin)return
            var msg = {action:!currentObj.isLike,option:"like"}
            copyObj(currentObj,msg)
            actionWork.sendMessage(msg)
            currentObj.isLike = !currentObj.isLike
            modelChanged(currentObj)
        }

        onEmail:{
            feedMenu.hide()
            if(!chkLogin)return
            sendmail()
        }

        onComment:{
            feedMenu.hide()
            if(!chkLogin)return
            doComment()
        }



    }
}
