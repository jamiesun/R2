import Qt 4.7
Rectangle {
    id: ctx_view
    radius: 10
    width: 240
    height: 320
    Behavior on opacity{NumberAnimation{duration: 200}}

    TextEdit {
        id: ctx
        x: 5;y: 5
        width: parent.width-10
        color: "#000000"
        text: ""
        clip: false
        readOnly: true
        textFormat: TextEdit.RichText
        font.pointSize: 9
        wrapMode: TextEdit.WrapAnywhere
    }
}
