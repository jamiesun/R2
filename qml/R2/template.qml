import Qt 4.7

Rectangle {
    id: bg
    width: 320
    height: 240
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#4d4d4d"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }



    Rectangle {
        id: notice
        height:30
        color: "#c0c0c0"
        radius: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Text {
            id: text1
            text: "text"
            anchors.centerIn: parent
        }
    }
}
