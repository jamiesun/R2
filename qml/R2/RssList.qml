import Qt 4.7
import "models"
Rectangle {
    id:rsslist
    property string auth: ''
    property string sid: ''
    property string tag: ""
    property string source: "rss.xml"
    Behavior on opacity{NumberAnimation{duration: 200}}
    width: 320
    height: 240
    signal back()
    signal itemClick(string title,string url)

    function filter(tag){
        rsslist.tag = tag
        rssModel.filter(tag)
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

    RssModel{
        id:rssModel;auth: rsslist.auth;sid: rsslist.sid
        onError: console.log(error)
    }

    RssToolBar {
        id: rsstoolbar
        title: rsslist.tag
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
        model: rssModel
        delegate: RssItem{
            id:rssItem
            Keys.onRightPressed:itemClick(rssItem.title,rssItem.feed)
            Keys.onSelectPressed:itemClick(rssItem.title,rssItem.feed)
        }

        KeyNavigation.left:rsstoolbar
        Loading{
            id:loading
            anchors.fill: parent
            show: rssModel.busy
        }

    }

    MenuBar {
        id: menubar1
        y: 216
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }
}