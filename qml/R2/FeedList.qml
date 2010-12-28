import Qt 4.7
import "models"
Item {
    id:feedlist
    property alias auth: feedModel.auth
    property alias sid: feedModel.sid
    property string token: ""
    property string title: ""
    property alias feedMax: feedModel.feedMax


    Behavior on opacity{NumberAnimation{duration: 200}}
    width: 320
    height: 240
    signal back()
    signal home()
    signal itemClick(string content)


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

    function update(title,url){
        feedlist.title = title
        feedModel.update(url)
    }

    function clickitem(){
        var it =  list_view.currentItem;
        itemClick("<h3>"+it.title+"</h3>"+it.content)
        actionWork.sendMessage({auth:main.auth,sid:main.sid,token:main.token,action:"read",entry:it.itid,streamId:it.streamId})
    }

    function previous(){
        list_view.decrementCurrentIndex();
        var it =  list_view.currentItem;
        actionWork.sendMessage({auth:main.auth,sid:main.sid,token:main.token,action:"read",entry:it.itid,streamId:it.streamId})
        return "<h3>"+it.title+"</h3>"+it.content
    }
    function next(){
        list_view.incrementCurrentIndex();
        var it =  list_view.currentItem;
        actionWork.sendMessage({auth:main.auth,sid:main.sid,token:main.token,action:"read",entry:it.itid,streamId:it.streamId})
        return "<h3>"+it.title+"</h3>"+it.content
    }

    onFocusChanged: {
        if(activeFocus){
            list_view.forceActiveFocus()
        }
    }

    Keys.onPressed:{
        if(event.key == '17825793'){
            back()
        }
        if(event.key == '17825792'){
            home()
        }
    }



    FeedModel{
        id:feedModel
        onError: console.log(error)
    }

    RssToolBar {
        id: rsstoolbar
        title: feedlist.title
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        KeyNavigation.up:list_view;KeyNavigation.down:list_view
        onReload:feedModel.reload()
    }

    ListView {
        id: list_view
        anchors.bottomMargin: 24
        anchors.top: rsstoolbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
        clip: true
        model: feedModel
        delegate: FeedItem{
            id:feedItem
            Keys.onRightPressed:clickitem()
            Keys.onSelectPressed:clickitem()
        }

        KeyNavigation.left:rsstoolbar
        Loading{
            id:loading
            anchors.fill: parent
            show: feedModel.busy
        }

    }

    MenuBar {
        id: menubar1
        type: "feed"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }
}
