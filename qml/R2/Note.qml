import Qt 4.7

FocusScope {
    id: bg
    width: parent.width
    height: parent.height
    Behavior on opacity{NumberAnimation{duration: 200}}
    signal createNote(string tags,string content)
    signal cancel()

    Keys.onPressed:{
        if(event.key==17825793)cancel()
        else if(event.key==17825792){
            if(!note_.text)return
            createNote(tag_.text,note_.text)
        }
    }
    onFocusChanged:{
        if(activeFocus){
            tag_.forceActiveFocus()
            tag_.text = ""
            note_.text = ""
        }
    }
    KeyNavigation.down:tag_


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
        type:"comment"
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
            text: "Add Note"
            font.weight: Font.DemiBold
            font.pointSize:mainApp.fontSize
            style: "Raised"
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: box1
        height: 32
        radius: 5
        color: tag_.activeFocus?"#ffffff":"#e8e8e8"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: tbar.bottom
        anchors.topMargin: 10

        TextInput {
            id: tag_
            text: ""
            cursorVisible: activeFocus
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: text2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            KeyNavigation.down:note_
            KeyNavigation.up:note_
        }

        Text {
            id: text2
            color: "#000000"
            text: "Tag:"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize:mainApp.fontSize
        }
    }

    Rectangle {
        id: box2
        color: note_.activeFocus?"#ffffff":"#e8e8e8"
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
            id: note_
            text: ""
            wrapMode: TextEdit.WrapAnywhere
            font.pointSize:mainApp.fontSize
            cursorVisible: activeFocus
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            anchors.fill: parent
            KeyNavigation.up:tag_
            KeyNavigation.down:tag_
        }
    }
}
