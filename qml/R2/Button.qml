import Qt 4.7

Item {
    id: container

    signal clicked

    property string text

    BorderImage {
        id: buttonImage
        source: "pics/toolbutton.sci"
        width: container.width; height: container.height
    }
    BorderImage {
        id: pressed
        opacity: 0
        source: "pics/toolbutton.sci"
        width: container.width; height: container.height
    }
    MouseArea {
        id: mouseRegion
        anchors.fill: buttonImage
        onClicked: { container.clicked(); }
    }
    Text {
        color: "white"
        anchors.centerIn: buttonImage; font.bold: true
        text: container.text; style: Text.Raised; styleColor: "black"
    }
    states: [
        State {
            name: "Pressed"
            when: mouseRegion.pressed == true || Keys.onSelectPressed
            PropertyChanges { target: pressed; opacity: 1 }
        }
    ]
}
