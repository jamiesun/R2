import Qt 4.7

Item {
    id:toolbar
    width: 320
    height: 40

    onFocusChanged: {
        if(activeFocus){
           tagAdd.forceActiveFocus()
        }
    }

    Rectangle {
        id: rectangle1
        color: "#0d0d0d"
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
    }
}
