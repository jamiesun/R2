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

    Behavior on contentY{NumberAnimation{duration: 500;easing.type: Easing.InOutQuart}}

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
        if(photo_view.activeFocus)return
        feedMenu.show()
    }

    Keys.onPressed:{
        if(photo_view.activeFocus)return
        if(event.key == '17825793'){
            photo_view.hide()
            feedMenu.hide()
            back()
        }
        if(event.key == '17825792'){
            photo_view.hide()
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

        var ms = currentObj.content.match(re)
        if(ms){
            for(var i =0 ;i<ms.length;i++){
                if(imgs.indexOf(RegExp.$2)==-1)
                    imgs.push(RegExp.$2)
            }
            flickable.images = imgs
        }
        ctx_view.hasImage = imgs.length>0


        ctx_view.content = "<html><head><style> body{font-size：12px;} img{max-width:"
                  + (flickable.parent.width-20)
                  + "px;} </style></head>"
                  + "<body><h3>"+currentObj.title+"</h3>"
                  + currentObj.content.replace(re2,"")
                  + "</body>"


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


    Keys.onUpPressed:{
        if(photo_view.activeFocus)return
        if(!atYBeginning)
            contentY -= Math.min(parent.height,Math.abs(contentY));
        else
            ctx_view.focus = true
    }
    Keys.onDownPressed:{
        if(photo_view.activeFocus)return
        if(!atYEnd)
            contentY += Math.min(parent.height,Math.abs(parent.height-(contentHeight-contentY)));
    }

    Keys.onLeftPressed:{
        if(photo_view.activeFocus)return
        previous()
    }
    Keys.onRightPressed:{
        if(photo_view.activeFocus)return
        next()
    }

    FeedView{
        id: ctx_view
        radius:5
        x: 0;y: 0
        KeyNavigation.down:flickable
        onPhotoChicked: {
            photo_view.show()
            photo_view.update(flickable.images)
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

    PhotoView{
        id:photo_view
        x:0;y:0
        opacity: 0
        width: flickable.parent.width
        height: flickable.parent.height
        onClose: {
            photo_view.hide()
            flickable.forceActiveFocus()
        }



    }


}
