import Qt 4.7

Rectangle {
    id: main
    width: 320
    height: 240
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

    Keys.onPressed:console.log(event.key)


    TagList {
        id: taglist
        anchors.fill: parent
        focus: true
        onItemClick: {
            main.state = "showRsslist"
            rsslist.tag = tag
            rsslist.forceActiveFocus()
        }
    }

    RssList {
        id: rsslist
        anchors.fill: parent
        opacity: 0
        onBack:main.state = "showMain"
    }

    states: [
        State {
            name: "showRsslist"
            PropertyChanges {target: taglist;opacity: 0}
            PropertyChanges {target: rsslist;opacity: 1;focus:true}
        },
        State {
            name: "showMain"
            PropertyChanges {target: taglist;opacity: 1;focus:true}
            PropertyChanges {target: rsslist;opacity: 0}
        }
    ]
}
