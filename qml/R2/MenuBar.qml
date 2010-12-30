import Qt 4.7

Item{
    width: 320
    height: 24

    property string type: "index"

    Component.onCompleted:{

        if(type=="index"){
            lkey.source = ""
            rkey.source = "res/16/round_delete.png"
        }else if(type=="rss"||type=="feed"){
            lkey.source = "res/16/home.png"
            rkey.source = "res/16/undo.png"
        }else  if(type=="settings"||type=="sendmail"){
            lkey.source = "res/16/checkmark.png"
            rkey.source = "res/16/cancel.png"
        }

    }

    Rectangle {
        id:bar
        radius: 5
        anchors.fill: parent
        opacity: 0.9

        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#1e1e1e"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }

    }

    Image {
        id: lkey
        anchors.left: parent.left
        anchors.leftMargin: 10
        opacity: 0.9
        anchors.verticalCenter: parent.verticalCenter
        source: "res/16/home.png"
    }

    Image {
        id: rkey
        opacity: 0.9
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "res/16/undo.png"
    }

}
