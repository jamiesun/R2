import Qt 4.7
Rectangle {
    id: notice
    width: parent.width
    height: 24
    color: "#dddddd"
    radius: 0
    Behavior on opacity{NumberAnimation{duration: 500}}

    function show(msg){
        msg_.text = msg
        tmr.start()
        opacity = 1
    }

    Timer{
        id:tmr
        interval: 2000;running: false;repeat: false;triggeredOnStart: false
        onTriggered: notice.opacity = 0
    }

    Text {
        id: msg_
        text: ""
        anchors.centerIn: parent
        font.pointSize:mainApp.fontSize
    }
}
