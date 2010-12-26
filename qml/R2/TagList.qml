import Qt 4.7

Rectangle {
    id:taglist
    property string source: "tags.xml"
    Behavior on opacity{NumberAnimation{duration: 200}}
    width: 320
    height: 240
    signal itemClick(string tag)

    onFocusChanged: {
        if(activeFocus){
            list_view.forceActiveFocus()
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
        source:taglist.source
        query: "/items/item"
        XmlRole { name: "tagname"; query: "@name/string()" }
    }

    ToolBar {
        id: toolbar
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
        anchors.top: toolbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
        clip: true
        keyNavigationWraps: true
        model: tagsModel
        delegate: TagItem{
            id:tagItem
            Keys.onRightPressed:itemClick(tagItem.title)
            Keys.onSelectPressed:itemClick(tagItem.title)
        }

        KeyNavigation.left:toolbar

    }
}
