import Qt 4.7

Item {
    id: loading
    property bool show: false
    width: parent.width
    opacity: show?1:0
    AnimatedImage {
        id: loadimg
        x: 0
        y: 0
        anchors.centerIn: parent
        source: "res/loading.gif"
    }
}
