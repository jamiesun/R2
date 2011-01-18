import Qt 4.7

Rectangle {
    id: rectangle1
    width: 320
    height: 240
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#252525"
        }

        GradientStop {
            position: 0.98
            color: "#000000"
        }
    }
    signal back()

    Keys.onPressed:{
        if(event.key == '17825793'){
            back()
        }
    }

    Keys.onSelectPressed:back()


    Text {
        id: title
        color: "#ffffff"
        text: "Welcome use R2"
        styleColor: "#ffffff"
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        font.pointSize: 9
    }

    Text {
        id: dev
        color: "#fdfdfd"
        text: "Author:jamiesun"
        font.pointSize: 9
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
        source: "res/jamiesun.jpg"
    }

    Text {
        id: email
        color: "#f9f9f9"
        text: "jamiesun.net@gmail.com"
        font.pointSize: 9
        anchors.top: image1.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 20
        anchors.left: parent.left
    }



}
