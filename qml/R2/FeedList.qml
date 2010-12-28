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
    signal itemClick()

    function getCurrentObj(){
        var obj = feedModel.get(list_view.currentIndex)
        obj.token = token
        return obj;
    }

    function setCurrentObj(obj){
        feedModel.set(list_view.currentIndex,obj)
    }

    function update(title,url){
        feedlist.title = title
        feedModel.update(url)
    }

    function previous(){
        list_view.decrementCurrentIndex();
    }
    function next(){
        list_view.incrementCurrentIndex();
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
            Keys.onRightPressed:itemClick()
            Keys.onSelectPressed:itemClick()
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
