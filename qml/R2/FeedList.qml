import Qt 4.7
import "models"
Item {
    id:feedlist
    property string title: ""
    property alias feedMax: feedModel.feedMax
    Behavior on opacity{NumberAnimation{duration: 200}}
    width: 320
    height: 240
    signal back()
    signal home()
    signal itemClick()
    signal notice(string msg)

    function getCurrentObj(){
        return feedModel.get(list_view.currentIndex)
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
        onError: notice(error)
    }

    FeedToolBar {
        id: feedtoolbar
        title: feedlist.title
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        KeyNavigation.up:list_view;KeyNavigation.down:list_view
        onLoadCache: feedModel.loadCache()
        onLoadNew: feedModel.loadNew()
        onUpdateCache: feedModel.updateCache()
    }

    ListView {
        id: list_view
        anchors.bottomMargin: 24
        anchors.top: feedtoolbar.bottom
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

        KeyNavigation.left:feedtoolbar
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
