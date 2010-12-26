import Qt 4.7
import "models"
Rectangle {
    id:taglist
    property string auth: ''
    property string sid: ''
    property string source: "tags.xml"
    Behavior on opacity{NumberAnimation{duration: 200}}
    width: 320
    height: 240
    signal itemClick(string tag)

    function updateModel(mauth,msid){
        auth = mauth
        sid = msid
        tagsModel.update()
    }

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
    TagsModel{
        id:tagsModel;auth: taglist.auth;sid: taglist.sid
        onError: console.log(error)
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
        anchors.bottomMargin: 24
        anchors.top: toolbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
        clip: true
        model: tagsModel
        delegate: TagItem{
            id:tagItem
            Keys.onRightPressed:itemClick(tagItem.title)
            Keys.onSelectPressed:itemClick(tagItem.title)
        }

        KeyNavigation.left:toolbar

        Loading{
            id:loading
            anchors.fill: parent
            show: tagsModel.busy
        }

    }

    IMenuBar {
        id: imenubar1
        y: 216
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
    }

}