import Qt 4.7
import QtWebKit 1.0
Flickable {
    property bool hide: true
    property variant currentObj: {}
    id: flickable
    width: parent.width
    contentWidth: Math.max(parent.width,web_view.width)
    contentHeight: Math.max(parent.height,web_view.height)
    pressDelay: 200
    smooth: true

    Behavior on contentY{NumberAnimation{duration: 400;easing.type: Easing.InOutQuart}}

    signal next()
    signal previous()
    signal back()
    signal home()
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
        if(!currentObj.isRead){
            var msg = {action:true,option:"read"}
            copyObj(currentObj,msg)
            actionWork.sendMessage(msg)
            currentObj.isRead = true
            modelChanged(currentObj)
        }
        web_view.html = "<style> body{font-size：12px;} img{max-width:"
                  + (flickable.parent.width-20)
                  + "px;} </style>"
                  + "<h3>"+currentObj.title+"</h3>"
                  + currentObj.content
        web_view.forceActiveFocus()

    }


    Rectangle{
        anchors.fill: parent
        color: "#ffffff"
        opacity: web_view.opacity
    }

    property int histx : 0
    property int histy : 0

    function resetTbar(){
        feedMenu.x += contentX-histx
        feedMenu.y += contentY-histy
        histx = contentX
        histy = contentY
    }
    onContentXChanged: resetTbar()
    onContentYChanged: resetTbar()


    onFocusChanged: {
        if(activeFocus){
            web_view.forceActiveFocus()
        }

    }

    WebView {
        id: web_view
        x: 0;y: 0
        opacity:  hide?0.0:1.0
        clip: true
        preferredWidth: flickable.width
        preferredHeight: flickable.height+5
        settings.offlineWebApplicationCacheEnabled:true

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


    }


}
