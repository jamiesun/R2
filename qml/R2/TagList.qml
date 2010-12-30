import Qt 4.7
import "models"
Item {
    id:taglist
    property string auth: ''
    property string sid: ''
    Behavior on opacity{NumberAnimation{duration: 200}}
    width: 320
    height: 240
    signal itemClick(string tag)
    signal doSettings()

    function updateModel(mauth,msid){
        auth = mauth
        sid = msid
        tagsModel.update()
    }

    Keys.onPressed:{
        if(event.key == '17825793'){
            taglist.state = "showQuitAlert"
        }
    }

    onFocusChanged: {
        if(activeFocus){
            list_view.forceActiveFocus()
        }
    }

//    gradient: Gradient {
//        GradientStop {
//            position: 0
//            color: "#363636"
//        }

//        GradientStop {
//            position: 1
//            color: "#000000"
//        }
//    }
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
        onSettings: doSettings()
        onReload:tagsModel.update()
    }

    ListView {
        id: list_view
        anchors.bottomMargin: 24
        anchors.top: toolbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0
        keyNavigationWraps:true
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

    MenuBar {
        id: menubar1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        type: "index"
    }
    Alert{
        id:alert;opacity: 0
        anchors.centerIn: parent
    }

    states: [
        State {
            name: "showQuitAlert"
            PropertyChanges {
                target: alert;focus:true;msg:"Are you quit?";opacity:1;onOk:Qt.quit();onCancel:taglist.state=""
            }
        }
    ]

}
