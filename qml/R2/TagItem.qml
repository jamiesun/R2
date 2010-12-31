import Qt 4.7

FocusScope {
    id: tagItem
    width: parent.width
    height: activeFocus?40:32
    Behavior on height{NumberAnimation{duration: 200}}
    property alias title: title.text
    property string tid: tagid


    function setCount(countvar){
        count.text = countvar
    }


    Rectangle {
        id: rectangle1
        radius: 5
        opacity: 0.7
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
        opacity: tagItem.activeFocus?1:0.5
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        source: "res/16/tag.png"
    }

    Text {
        id: title
        smooth: true
        width: 80
        height: 20
        color: "#ffffff"
        text: tagname
        font.pointSize:8
        anchors.left: tagimg.right
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: go
        scale: tagItem.activeFocus?0.6:0.4
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        source: "res/16/br_next.png"
        opacity: tagItem.activeFocus?0.9:0.5
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
