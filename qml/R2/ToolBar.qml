import Qt 4.7

Item {
    id:toolbar
    width:parent.width
    height: 30

    signal settings()
    signal note()

    onFocusChanged: {
        if(activeFocus){
           notes.forceActiveFocus()
        }
    }

    Rectangle {
        id: rectangle1
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
        anchors.fill: parent

        Image {
            id: image1
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            source: "res/logo.png"
        }
    }

    Image {
        id: notes
        smooth: true
        opacity: activeFocus?1:0.7
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: activeFocus?"res/16/notepad.png":"res/16/notepad_2.png"
        KeyNavigation.right:setting;KeyNavigation.left:setting
        Keys.onSelectPressed:toolbar.note()
    }

    Image {
        id: setting
        smooth: true
        opacity: activeFocus?1:0.7
        anchors.left: notes.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "res/16/wrench_plus_2.png"
        KeyNavigation.left:notes;KeyNavigation.right:notes
        Keys.onSelectPressed:toolbar.settings()
    }


}
