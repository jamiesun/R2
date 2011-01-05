import Qt 4.7

Item {
    id: rssitem
    width: parent.width
    height: activeFocus?title.height+20:title.height+10
    Behavior on height{NumberAnimation{duration: 200}}
    property string feed: feedid
    property string title: feedtitle

    Rectangle {
        id: bg
        radius: 10
        opacity: 0.7
        gradient: Gradient {
            GradientStop {
                id: gradientstop1
                position: 0
                color: "#252525"
                Behavior on color{PropertyAnimation{duration: 200}}
            }


            GradientStop {
                id: gradientstop2
                position: 1
                color: "#0d0d0d"
                Behavior on color{PropertyAnimation{duration: 200}}
            }
        }
        anchors.rightMargin: 1
        anchors.leftMargin: 1
        anchors.bottomMargin: 1
        anchors.topMargin: 1
        anchors.fill: parent
    }

    TextEdit {
        id: title
        clip: false
        color: "#f5ecec"
        text: rssitem.title + (count?" ("+count+")":"")
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: feedImg.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        wrapMode: TextEdit.WrapAnywhere
        font.pointSize:mainApp.fontSize
    }

    Image {
        id: feedImg
        y: 0
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "res/16/rss.png"
        opacity: rssitem.activeFocus?1:0.6
    }


    states: [
        State {
            name: "selected";when:activeFocus

            PropertyChanges {
                target: gradientstop1
                position: 0
                color: "#424242"
            }


            PropertyChanges {
                target: gradientstop2
                position: 1
                color: "#2f2f2f"
            }
        }
    ]

}
