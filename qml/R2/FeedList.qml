import Qt 4.7
import "models"
Rectangle {
    id:feedlist
    property string auth: ''
    property string sid: ''
    property string title: ""
    Behavior on opacity{NumberAnimation{duration: 200}}
    width: 320
    height: 240
    signal back()
    signal home()
    signal itemClick(string content)

    function update(title,url){
        feedlist.title = title
        feedModel.update(url)
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


    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#363636"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }

    FeedModel{
        id:feedModel;auth: feedlist.auth;sid: feedlist.sid
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
            Keys.onRightPressed:itemClick(feedItem.content)
            Keys.onSelectPressed:itemClick(feedItem.content)
        }

        KeyNavigation.left:rsstoolbar
        Loading{
            id:loading
            anchors.fill: parent
            show: feedModel.busy
        }

    }

    IMenuBar {
        id: menubar1
        lkey: "Home";rkey: "Back"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }
}
