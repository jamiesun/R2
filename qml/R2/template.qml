import Qt 4.7

Rectangle {
    width: 320
    height: 240
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#8d8d8d"
        }

        GradientStop {
            position: 1
            color: "#c4c4c4"
        }
    }

    TextEdit {
        id: text_edit1
        color: "#000000"
        text: "textEdit"
        clip: false
        readOnly: true
        textFormat: TextEdit.RichText
        font.pointSize: 9
        wrapMode: TextEdit.WrapAnywhere
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.fill: parent
    }
}
