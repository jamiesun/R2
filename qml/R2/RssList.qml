import Qt 4.7

Rectangle {
    id:rsslist
    property string tag: "tag"
    property string source: "rss.xml"
    Behavior on opacity{NumberAnimation{duration: 200}}
    width: 320
    height: 240
    signal back()

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

    XmlListModel{
        id:tagsModel
        source:rsslist.source
        query: "/items/item"
        XmlRole { name: "rssname"; query: "@name/string()" }
        XmlRole { name: "rssdesc"; query: "desc/string()" }
        XmlRole { name: "rssurl"; query: "@url/string()" }
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
        keyNavigationWraps: true
        model: tagsModel
        delegate: RssItem{
            id:rssItem
        }

        KeyNavigation.left:rsstoolbar

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
