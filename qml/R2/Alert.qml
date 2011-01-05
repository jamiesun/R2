import Qt 4.7

Item {
    id: item1
    width: 230//parent.width-40
    height: 160
    Behavior on opacity{NumberAnimation{duration: 200}}
    property string  msg: ""
    signal ok()
    signal cancel()

    function show(text){
        opacity = 1
        content.text = text
        focus = true
    }
    function close(){
        opacity = 0
        parent.focus = true
    }




    onFocusChanged: {
        if(activeFocus){
            buttonok.focus = true
        }
    }

    Rectangle {
        id: rectangle1
        radius: 10
        gradient: Gradient {
            GradientStop {
                position: 0.02
                color: "#737373"
            }

            GradientStop {
                position: 0.96
                color: "#424242"
            }

            GradientStop {
                position: 0.21
                color: "#080a0d"
            }
        }
        anchors.fill: parent
        opacity: 0.9
        border.width: 3
        border.color: "#ffffff"

        Button {
            id: buttonok
            width: 74
            height: 29
            text: "Ok"
            opacity: activeFocus?1:0.8
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            KeyNavigation.right:buttoncal
            onClicked: {
                item1.close()
                item1.ok()
            }
        }

        Button {
            id: buttoncal
            opacity: activeFocus?1:0.8
            width: 74
            height: 29
            text: "Cancel"
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            KeyNavigation.left:buttonok
            onClicked: {
                item1.close()
                item1.cancel()
            }
        }
    }

    Text {
        id: content
        color: "#ffffff"
        text:msg
        font.bold: false
        font.pointSize:mainApp.fontSize
        font.weight: Font.DemiBold
        wrapMode: TextEdit.WrapAnywhere
        textFormat: TextEdit.RichText
        anchors.fill: parent
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        anchors.bottomMargin: 65
        anchors.topMargin: 30
    }
}
