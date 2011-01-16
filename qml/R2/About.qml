import Qt 4.7

Rectangle {
    id: rectangle1
    width: 320
    height: 240
    signal click()

    MouseArea{
        anchors.fill:parent
        onClicked:click()
    }

    Keys.onSelectPressed:click()

    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#b5b5b5"
        }

        GradientStop {
            position: 1
            color: "#4b4b4b"
        }
    }

    Text {
        id: title
        text: "Welcome use MyReader"
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pointSize: 10
    }

    Text {
        id: dev
        text: "Author:jamiesun"
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: title.bottom
        anchors.topMargin: 10
    }

    Image {
        id: image1
        width:72;height:72
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: dev.bottom
        anchors.topMargin: 10
        source: "pic/jamiesun.jpg"
    }

    Text {
        id: email
        text: "jamiesun.net@gmail.com"
        font.pointSize: 9
        anchors.top: image1.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 20
        anchors.left: parent.left
    }

    Text {
        id: ver
        text: "Version: 1.0"
        anchors.top: email.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 20
        anchors.left: parent.left
    }

    Text {
        id: pubdate
        text: "Publish date:2010-12-13"
        anchors.top: ver.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 20
        anchors.left: parent.left
    }


}
