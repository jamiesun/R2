import Qt 4.7
import QtWebKit 1.0
Flickable {
    property bool hide: true
    property variant currentObj: {}
    property bool showMouse: false


    id: flickable
    width: parent.width
    contentWidth: Math.max(parent.width,web_view.width)
    contentHeight: Math.max(parent.height,web_view.height)
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
    signal setMouse(bool isShow)
    signal modelChanged(variant obj)

    WorkerScript {
        id: actionWork
        source: "edittag.js"
        onMessage: {
            if(messageObject.code==0){
                console.log("action success")
            }
            else{
                console.log("action faild");
            }
        }
    }

    Keys.onSelectPressed:{
        feedMenu.show()
    }

    Keys.onPressed:{
        if(event.key == '17825793'){
            feedMenu.hide()
            showMouse = false
            setMouse(showMouse)
            back()
        }
        if(event.key == '17825792'){
            feedMenu.hide()
            showMouse = !showMouse
            setMouse(showMouse)
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
        if(!currentObj.isRead){
            var msg = {action:true,option:"read"}
            copyObj(currentObj,msg)
            actionWork.sendMessage(msg)
            currentObj.isRead = true
            modelChanged(currentObj)
        }
        web_view.html = "<style> body{background:white;font-size：12px;} img{max-width:"
                  + (flickable.parent.width-20)
                  + "px;} </style>"
                  + "<h3>"+currentObj.title+"</h3>"
                  + currentObj.content
        web_view.forceActiveFocus()
        contentX = 0
        contentY = 0
    }


    Rectangle{
        anchors.fill: parent
        color: "#ffffff"
        opacity: web_view.opacity
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
        settings.javascriptEnabled:true
        settings.linksIncludedInFocusChain:true
        settings.localContentCanAccessRemoteUrls:true
        settings.pluginsEnabled:true
        settings.offlineWebApplicationCacheEnabled:true
        Behavior on opacity{NumberAnimation{duration:200}}


        onLoadFinished:{
            evaluateJavaScript("document.body.background='white'';")
        }

        Keys.onUpPressed:{
            if(!flickable.atYBeginning)
                flickable.contentY -= Math.min(flickable.parent.height/2,Math.abs(flickable.contentY));
        }
        Keys.onDownPressed:{
            if(!flickable.atYEnd)
                flickable.contentY += Math.min(flickable.parent.height/2,Math.abs(flickable.parent.height-(flickable.contentHeight-contentY)));
        }

        Keys.onLeftPressed:{
            if(flickable.atXBeginning){
                flickable.previous()
                if(showMouse)web_view.back.trigger()
            }
            else
                flickable.contentX -= Math.min(flickable.parent.width/2,Math.abs(flickable.contentX));

        }
        Keys.onRightPressed:{
            if(flickable.atXEnd)
                flickable.next()
            else
                flickable.contentX += Math.min(flickable.parent.width/2,Math.abs(flickable.parent.width-(flickable.contentWidth-contentX)));
        }

    }



    Loading{
        id:loading
        x:(flickable.parent.width - loading.width)/2
        y:(flickable.parent.height - loading.height)/2
        show: web_view.progress<1
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
            var msg = {action:!currentObj.isShare,option:"broadcast"}
            copyObj(currentObj,msg)
            actionWork.sendMessage(msg)
            currentObj.isShare = !currentObj.isShare
            modelChanged(currentObj)
        }
        onStar:{
            var msg = {action:!currentObj.isStar,option:"starred"}
            copyObj(currentObj,msg)
            actionWork.sendMessage(msg)
            currentObj.isStar = !currentObj.isStar
            modelChanged(currentObj)
        }

        onLike:{
            var msg = {action:!currentObj.isLike,option:"like"}
            copyObj(currentObj,msg)
            actionWork.sendMessage(msg)
            currentObj.isLike = !currentObj.isLike
            modelChanged(currentObj)
        }

        onEmail:{
            feedMenu.hide()
            sendmail()
        }

        onComment:{
            feedMenu.hide()
            doComment()
        }


    }
}
