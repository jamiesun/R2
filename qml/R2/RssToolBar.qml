import Qt 4.7

Item {
    id:toolbar
    width: parent.width
    height: 40
    property string title: ""

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
        anchors.left: parent.left
        anchors.leftMargin: 10
        style: "Raised"
        elide:Text.ElideRight
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize:mainApp.fontSize
    }

}
