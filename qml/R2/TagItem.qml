import Qt 4.7

FocusScope {
    id: tagItem
    width: parent.width
    height: activeFocus?40:32
    Behavior on height{NumberAnimation{duration: 200}}
    property string title: title.text

    function setCount(countvar){
        count.text = countvar
    }


    Rectangle {
        id: rectangle1
        radius: 5
        gradient: Gradient {
            GradientStop {
                id: gradientstop1
                position: 0
                color: "#252525"
                Behavior on color{PropertyAnimation{duration: 200}}
            }


            GradientStop {
                id: gradientstop3
                position: 1
                color: "#0d0d0d"
                Behavior on color{PropertyAnimation{duration: 200}}
            }
        }
        anchors.fill: parent

    }

    Image {
        id: tagimg
        x: 7
        y: 4
        opacity: tagItem.activeFocus?1:0.5
        anchors.verticalCenter: parent.verticalCenter
        source: "pics/tag_24.png"
    }

    Text {
        id: title
        y: 8
        width: 80
        height: 20
        color: "#ffffff"
        text: tagname
        anchors.left: tagimg.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: count
        x: 283
        y: 6
        height: 20
        color: "#ffffff"
        text: "0"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        font.bold: false
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
                target: gradientstop3
                position: 1
                color: "#2f2f2f"
            }
        }
    ]
}
