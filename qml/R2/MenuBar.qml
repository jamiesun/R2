import Qt 4.7

Rectangle {
    id: rectangle1
    width: 320
    height: 24
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
        x: 0
        y: 3
        width: 54
        height: 19
        text: "Menu"
        anchors.verticalCenterOffset: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        id: button2
        x: 266
        y: 2
        width: 54
        height: 19
        text: "Back"
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
        anchors.leftMargin: 5
    }
}
