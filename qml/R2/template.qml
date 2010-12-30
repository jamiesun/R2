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

    MenuBar {
        id: menubar
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        type:"sendmail"
    }

    Rectangle {
        id: tbar
        width: 320
        height: 30
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#333333"
            }

            GradientStop {
                position: 0.54
                color: "#111111"
            }

            GradientStop {
                position: 0.45
                color: "#252525"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top

        Text {
            id: title_
            color: "#ffffff"
            text: "Send Mail"
            font.bold: true
            font.pointSize: 8
            style: "Raised"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: box1
        height: 32
        radius: 5
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#eeeeee"
            }

            GradientStop {
                position: 0.93
                color: "#c4c4c4"
            }
        }
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: tbar.bottom
        anchors.topMargin: 10

        TextInput {
            id: mailto
            text: ""
            cursorVisible: true
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: text2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            echoMode: "Normal"
        }

        Text {
            id: text2
            color: "#000000"
            text: "To:"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 9
        }
    }

    Rectangle {
        id: box2
        color: "#e8e8e8"
        radius: 5
        anchors.top: rectangle2.bottom
        anchors.right: parent.right
        anchors.bottom: menubar1.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        TextEdit {
            id: mailnote
            text: ""
            cursorVisible: true
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            anchors.fill: parent
        }
    }
}
