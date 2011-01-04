import Qt 4.7

Item {
    id:toolbar
    width: parent.width
    height: 40
    property string title: ""
    signal loadNew()
    signal updateCache()
    signal loadCache()
    onFocusChanged:{
        if(activeFocus){
           olditem.focus = true
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
        anchors.left: newitem.right
        anchors.leftMargin: 10
        style: "Raised"
        elide:Text.ElideRight
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 8
        font.bold: true
    }


    Image {
        id: olditem
        x: 0
        y: 0
        source: "res/16/eye.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 10
        opacity: activeFocus?1:0.7
        anchors.left: parent.left
        Keys.onSelectPressed:toolbar.updateCache()
        KeyNavigation.left:newitem;KeyNavigation.right:newitem
        onFocusChanged: {
            if(activeFocus){
                loadCache()
            }
        }
    }
    Image {
        id: newitem
        opacity:activeFocus?1:0.7
        anchors.left: olditem.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "res/16/eye_inv.png"
        Keys.onSelectPressed:toolbar.loadNew()
        KeyNavigation.left:olditem;KeyNavigation.right:olditem
    }


}
