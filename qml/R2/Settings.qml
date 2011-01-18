import Qt 4.7
Item {
    id:config
    width: 240;height: 320
    property alias email: email_.text
    property alias passwd: passwd_.text
    property string feedMax: fnum.text
    signal finish()
    signal cancel()
    signal save(string cfgData)
    Behavior on opacity{NumberAnimation{duration: 200}}

    function doSave(){
        if(email_.text==""){ebox.forceActiveFocus();}
        else if(passwd_.text==""){pbox.forceActiveFocus();}
        else{
            var fnums = fnum.text?fnum.text:"30"
            save(email_.text+","+passwd_.text+","+fnums)
        }
    }


   Keys.onPressed:{
       if(event.key==17825793)cancel()
       else if(event.key==17825792)doSave()
   }



    onFocusChanged: {
        if(activeFocus){
            email_.forceActiveFocus()
        }
    }

    Flickable {
        id: box
        anchors.fill: parent
        anchors.bottomMargin: 24


        Text {
            id: text1
            width: 80
            height: 20
            color: "#ffffff"
            text: "Your Gmail:"
            anchors.top: parent.top
            anchors.topMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pointSize:mainApp.fontSize
        }

        Rectangle {
            id: ebox
            height: 30
            color: email_.activeFocus?"#ffffff":"#dbdbdb"
            radius: 5
            anchors.top: text1.bottom
            anchors.topMargin: 8
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            border.color: "#403e3e"
            border.width: email_.activeFocus?1:0

            TextInput {
                id: email_
                text: ""
                cursorVisible: activeFocus
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                anchors.topMargin: 5
                anchors.fill: parent
                font.pointSize:mainApp.fontSize
                KeyNavigation.down:passwd_;KeyNavigation.up:fnum
            }
        }

        Text {
            id: text2
            height: 20
            color: "#ffffff"
            text: "Your Password:"
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: ebox.bottom
            anchors.topMargin: 5
            font.pointSize:mainApp.fontSize
        }

        Rectangle {
            id: pbox
            height: 30
            color: passwd_.activeFocus?"#ffffff":"#dbdbdb"
            radius: 5
            anchors.top: text2.bottom
            anchors.topMargin: 8
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            border.color: "#403e3e"
            border.width: passwd_.activeFocus?1:0

            TextInput {
                id: passwd_
                text: ""
                echoMode: TextInput.PasswordEchoOnEdit
                cursorVisible: activeFocus
                font.pointSize:mainApp.fontSize
                anchors.fill: parent
                anchors.topMargin: 5
                anchors.rightMargin: 5
                anchors.bottomMargin: 5
                anchors.leftMargin: 5
                KeyNavigation.up:email_;KeyNavigation.down:fnum
            }
        }


        Text {
            id: text3
            x: 4
            y: 4
            height: 20
            color: "#ffffff"
            text: "Feeds maxnum:"
            font.pointSize:mainApp.fontSize
            anchors.top: pbox.bottom
            anchors.topMargin: 8
            anchors.leftMargin: 20
            anchors.left: parent.left
        }

        Rectangle {
            id: nums
            x: 4
            y: 4
            height: 30
            color: fnum.activeFocus?"#ffffff":"#dbdbdb"
            radius: 5
            anchors.top: text3.bottom
            border.color: "#403e3e"
            anchors.topMargin: 8
            KeyNavigation.up:passwd_;KeyNavigation.down:email_
            TextInput {
                id: fnum
                text: "30"
                validator: IntValidator{bottom: 10; top: 1000;}
                cursorVisible: activeFocus
                font.pointSize:mainApp.fontSize
                anchors.fill: parent
                anchors.topMargin:8
                anchors.rightMargin: 5
                anchors.bottomMargin: 5
                anchors.leftMargin: 5
            }
            anchors.rightMargin: 20
            border.width: fnum.activeFocus?1:0
            anchors.right: parent.right
            anchors.leftMargin: 20
            anchors.left: parent.left
        }
    }

    MenuBar {
        id: imenubar1
        type: "settings"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }

}
