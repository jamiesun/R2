import Qt 4.7

Item {
    id: rectangle2
    width: 140
    height: 24
    property alias icon: icon_.source
    property alias txt: txt_.text
    Behavior on focus{PropertyAnimation{duration: 200}}

    signal click()

    Keys.onSelectPressed:click()

    Rectangle {
        id: bg
        radius: 5
        anchors.fill: parent
        opacity: 0.9
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#363636"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
    }

    Image {
        id: icon_
        opacity: activeFocus?1:0.7
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "res/16/share.png"
    }

    Text {
        id: txt_
        color: "#ffffff"
        text: "text"
        anchors.left: icon_.right
        anchors.leftMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        clip: false
        font.pointSize: 8
        style: Text.Raised
    }
}
