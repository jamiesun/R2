import Qt 4.7

Item {
    id:toolbar
    width:320// parent.width
    height: 40

    signal settings()
    signal notes()
    signal reload()

    onFocusChanged: {
        if(activeFocus){
           reload.forceActiveFocus()
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
    }

    Image {
        id: notes
        opacity: activeFocus?1:0.7
        anchors.left: reload.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "pics/document_24.png"
        KeyNavigation.right:setting;KeyNavigation.left:reload
        Keys.onSelectPressed:toolbar.notes()
    }

    Image {
        id: setting
        opacity: activeFocus?1:0.7
        anchors.left: notes.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "pics/spanner_24.png"
        KeyNavigation.left:notes;KeyNavigation.right:reload
        Keys.onSelectPressed:toolbar.settings()
    }

    Image {
        id: reload
        opacity: activeFocus?1:0.7
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "pics/reload_24.png"
        KeyNavigation.left:setting;KeyNavigation.right:notes
        Keys.onSelectPressed:toolbar.reload()
    }

    Image {
        id: logo
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "pics/R2.png"
    }

}
