import Qt 4.7

FocusScope {
    id: bg
    width: parent.width
    height: parent.height
    Behavior on opacity{NumberAnimation{duration: 200}}
    signal send(string mailto,string content)
    signal cancel()

    Keys.onPressed:{
        if(event.key==17825793)cancel()
        else if(event.key==17825792)send(mailto_.text,mailnote_.text)
    }
    onFocusChanged:{
        if(activeFocus){
            mailto_.forceActiveFocus()
        }
    }
    KeyNavigation.down:mailto_


    Rectangle{
        opacity:0.7
        anchors.fill:parent
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
        width: parent.width
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
        color: mailto_.activeFocus?"#ffffff":"#e8e8e8"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: tbar.bottom
        anchors.topMargin: 10

        TextInput {
            id: mailto_
            text: ""
            cursorVisible: activeFocus
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: text2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            KeyNavigation.down:mailnote_
            KeyNavigation.up:mailnote_
        }

        Text {
            id: text2
            color: "#000000"
            text: "To:"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 8
        }
    }

    Rectangle {
        id: box2
        color: mailnote_.activeFocus?"#ffffff":"#e8e8e8"
        radius: 5
        anchors.top: box1.bottom
        anchors.right: parent.right
        anchors.bottom: menubar.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10

        TextEdit {
            id: mailnote_
            text: ""
            cursorVisible: activeFocus
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            anchors.fill: parent
            KeyNavigation.up:mailto_
            KeyNavigation.down:mailto_
        }
    }
}
