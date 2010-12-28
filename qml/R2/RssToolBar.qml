import Qt 4.7

Item {
    id:toolbar
    width: 320
    height: 40
    property string title: ""
    signal reload()
    onFocusChanged:{
        if(activeFocus){
           reload.focus = true
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
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: reload.right
        anchors.leftMargin: 10
        style: "Raised"
        elide:Text.ElideRight
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 8
        font.bold: true
    }

    Image {
        id: reload
        opacity:activeFocus?1:0.7
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "res/16/playback_reload.png"
        Keys.onSelectPressed:toolbar.reload()
    }
}
