import Qt 4.7

Item {
    id:toolbar
    width:320// parent.width
    height: 40

    signal settings()
    signal tagadd()

    onFocusChanged: {
        if(activeFocus){
           tagAdd.forceActiveFocus()
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

    Text {
        id: title
        color: "#ffffff"
        text: "R2 Reader"
        anchors.right: parent.right
        anchors.rightMargin:8
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 10
        font.bold: true
    }

    Image {
        id: tagAdd
        opacity: activeFocus?1:0.7
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "pics/tag_add_24.png"
        KeyNavigation.right:setting;KeyNavigation.left:setting
        Keys.onSelectPressed:tagadd()
    }

    Image {
        id: setting
        opacity: activeFocus?1:0.7
        anchors.left: tagAdd.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "pics/spanner_24.png"
        KeyNavigation.left:tagAdd;KeyNavigation.right:tagAdd
        Keys.onSelectPressed:settings()
    }

}
