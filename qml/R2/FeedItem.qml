import Qt 4.7

Item {
    id: feeditem
    width: parent.width
    height: activeFocus?title_.height+20:title_.height+10
    Behavior on height{NumberAnimation{duration: 200}}

    Rectangle {
        id: bg
        radius: 10
        opacity: 0.8
        gradient: Gradient {
            GradientStop {
                id: gradientstop1
                position: 0
                color: "#252525"
                Behavior on color{PropertyAnimation{duration: 200}}
            }


            GradientStop {
                id: gradientstop2
                position: 1
                color: "#0d0d0d"
                Behavior on color{PropertyAnimation{duration: 200}}
            }
        }
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1
        anchors.fill: parent
    }

    Text {
        id: title_
        clip: false
        color: "#f5ecec"
        text: title
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: feedImg.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        wrapMode: TextEdit.WrapAnywhere
        font.pointSize:mainApp.fontSize
    }

    Image {
        id: feedImg
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        source: isRead?"res/16/eye.png":"res/16/eye_inv.png"
        opacity: feeditem.activeFocus?1:0.6
    }

    states: [
        State {
            name: "selected";when:activeFocus

            PropertyChanges {
                target: gradientstop1
                position: 0
                color: "#646464"
            }


            PropertyChanges {
                target: gradientstop2
                position: 1
                color: "#2f2f2f"
            }
        }
    ]

}
