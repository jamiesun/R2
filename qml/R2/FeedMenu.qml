import Qt 4.7

Item {
    id: menu
    width: 160
    height: 195
    scale:0.5
    property bool isShare: false
    property bool isStar: false
    property bool isLike: false
    Behavior on opacity{NumberAnimation{duration: 200}}
    Behavior on scale{NumberAnimation{duration: 200}}

    signal close()
    signal share()
    signal star()
    signal like()
    signal email()
    signal comment()
    signal download()

    function show(){
        menu.opacity = 1
        menu.scale = 1
        menu.focus = true
    }

    function hide()
    {
        menu.opacity = 0
        menu.scale = 0.5
        menu.focus = false
    }

    onFocusChanged: {
        if(activeFocus){
            closed.forceActiveFocus()
        }
    }


    Rectangle {
        id: bg
        radius: 10
        anchors.fill: parent
        opacity: 0.9
        border.width: 3
        border.color: "#ececec"
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#515151"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
    }

    MenuItem {
        id: closed
        txt: "Close"
        icon: "res/16/cancel.png"
        opacity: activeFocus?1:0.7
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        Keys.onSelectPressed:menu.close()
        KeyNavigation.down:share;KeyNavigation.up:comment
    }

    MenuItem {
        id: share
        txt: isShare?"Unshare":"Share"
        icon: "res/16/share.png"
        opacity: activeFocus?1:0.7
        anchors.top: closed.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        Keys.onSelectPressed:{
            menu.share()
            menu.close()
        }
        KeyNavigation.down:like;KeyNavigation.up:closed
    }

    MenuItem {
        id: like
        txt: isLike?"Unlike":"like"
        icon: "res/16/heart_empty.png"
        opacity: activeFocus?1:0.7
        anchors.top: share.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        Keys.onSelectPressed:{
            menu.like()
            menu.close()
        }
        KeyNavigation.down:star;KeyNavigation.up:share
    }

    MenuItem {
        id: star
        icon: "res/16/star_fav_empty.png"
        txt: isStar?"Unstar":"star"
        opacity: activeFocus?1:0.7
        anchors.top: like.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        Keys.onSelectPressed:{
            menu.star()
            menu.close()
        }
        KeyNavigation.down:email;KeyNavigation.up:like
    }
    MenuItem {
        id: email
        icon: "res/16/mail.png"
        txt: "Email"
        opacity: activeFocus?1:0.7
        anchors.top: star.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        Keys.onSelectPressed:menu.email()
        KeyNavigation.down:comment;KeyNavigation.up:star
    }

    MenuItem {
        id: comment
        icon: "res/16/notepad_2.png"
        txt: "Note"
        opacity: activeFocus?1:0.7
        anchors.top: email.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        Keys.onSelectPressed:menu.comment()
        KeyNavigation.down:closed;KeyNavigation.up:email
    }
//    MenuItem {
//        id: download
//        icon: "res/16/download.png"
//        txt: "Save Image"
//        opacity: activeFocus?1:0.7
//        anchors.top: comment.bottom
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.topMargin: 5
//        anchors.rightMargin: 10
//        anchors.leftMargin: 10
//        Keys.onSelectPressed:menu.download()
//        KeyNavigation.down:closed;KeyNavigation.up:comment
//    }
}
