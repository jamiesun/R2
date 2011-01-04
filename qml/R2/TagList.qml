import Qt 4.7
import "models"
Item {
    id:taglist
    Behavior on opacity{NumberAnimation{duration: 200}}
    width: 320
    height: 240
    signal itemClick(string tagname,string tagid)
    signal doSettings()
    signal doNote()

    function updateModel(){
        tagsModel.update()
    }
    function reloadModel(){
        tagsModel.reload()
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

    TagsModel{
        id:tagsModel
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
        onNote:doNote()
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
            Keys.onRightPressed:itemClick(tagItem.title,tagItem.tid)
            Keys.onSelectPressed:itemClick(tagItem.title,tagItem.tid)
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
