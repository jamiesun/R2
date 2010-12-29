import Qt 4.7
import QtWebKit 1.0
Flickable {
    property bool hide: true
    property variant currentObj: {}
    property variant images: []
    id: flickable
    width: parent.width
    contentWidth: Math.max(parent.width,ctx_view.width)
    contentHeight: Math.max(parent.height,ctx_view.height)

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

        var imgs = []
        var re = /<IMG(.*?)src=\"*(.*?)\"*(\s|>)/gi
        var re2 = /<IMG(.*?)>/gi

        if(ms){
            var ms = currentObj.content.match(re)
            for(var i =0 ;i<ms.length;i++){
                imgs.push(RegExp.$2)
            }
            flickable.images = imgs
        }


        ctx.text = "<style> body{font-size：12px;} img{max-width:"
                  + (flickable.parent.width-20)
                  + "px;} </style>"
                  + "<h3>"+currentObj.title+"</h3>"
                  + currentObj.content.replace(re2,"")

        flickable.contentX = 0
        flickable.contentY = 0

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


//    onFocusChanged: {
//        if(activeFocus){
//            ctx_view.forceActiveFocus()
//        }

//    }

    Keys.onUpPressed:{
        if(!flickable.atYBeginning)
            flickable.contentY -= 40;
    }
    Keys.onDownPressed:{
        if(!flickable.atYEnd)
            flickable.contentY += 40;
    }

    Keys.onLeftPressed:{
        flickable.previous()
    }
    Keys.onRightPressed:{
        flickable.next()
    }

    Rectangle {
        id: ctx_view
        radius: 10
        x: 0;y: 0
        width: flickable.parent.width
        height: Math.max(flickable.parent.height,ctx.height+20)
        Behavior on opacity{NumberAnimation{duration: 200}}

        TextEdit {
            id: ctx
            x: 5;y: 5
            width: parent.width-10
            color: "#000000"
            text: ""
            clip: false
            readOnly: true
            textFormat: TextEdit.RichText
            font.pointSize: 9
            wrapMode: TextEdit.WrapAnywhere
        }
    }


    FeedMenu{
        id:feedMenu
        opacity: 0
        x:(flickable.parent.width - feedMenu.width)/2
        y:(flickable.parent.height - feedMenu.height)/2
        isShare: currentObj.isShare
        isStar: currentObj.isStar
        isLike: currentObj.isLike

        onClose: {
            feedMenu.hide()
            flickable.forceActiveFocus()
            console.log(flickable.images[0])
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
