import Qt 4.7

Rectangle {
    id: rectangle1
    width: 320
    height: 24
    property string lkey: "Menu"
    property string rkey: "Exit"

    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#1e1e1e"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }

    Button {
        id: button1
        opacity: button1.text?1:0
        width: 65
        height: 19
        text: lkey
        anchors.verticalCenterOffset: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        id: button2
        opacity: button2.text?1:0
        width: 65
        height: 19
        text: rkey
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
        anchors.leftMargin: 5
    }
}
