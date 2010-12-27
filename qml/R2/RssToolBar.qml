import Qt 4.7

Item {
    id:toolbar
    width: 320
    height: 40
    property string title: ""

    onFocusChanged: {
        if(activeFocus){
           rssAdd.forceActiveFocus()
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
        text: toolbar.title
        anchors.left: rssAdd.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 10
        font.bold: true
    }

    Image {
        id: rssAdd
        anchors.left: parent.left
        anchors.leftMargin: 10
        opacity: activeFocus?1:0.7
        anchors.verticalCenter: parent.verticalCenter
        source: "pics/plus_24.png"
    }
}
