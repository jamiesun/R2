import Qt 4.7

Item {
    id: feeditem
    width: parent.width
    height: activeFocus?title.height+20:title.height+10
    Behavior on height{NumberAnimation{duration: 200}}
    property string title: ititle
    property string content: icontent

    Rectangle {
        id: bg
        radius: 10
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
        opacity: 1
    }

    TextEdit {
        id: title
        clip: false
        color: "#f5ecec"
        text: feeditem.title
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: feedImg.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        wrapMode: TextEdit.WrapAnywhere
        font.bold: true
    }

    Image {
        id: feedImg
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        source: "pics/rss_24.png"
        opacity: feeditem.activeFocus?1:0.6
    }

    states: [
        State {
            name: "selected";when:activeFocus

            PropertyChanges {
                target: gradientstop1
                position: 0
                color: "#424242"
            }


            PropertyChanges {
                target: gradientstop2
                position: 1
                color: "#2f2f2f"
            }
        }
    ]

}
