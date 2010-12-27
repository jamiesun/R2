import Qt 4.7
import QtWebKit 1.0
Flickable {
    property string content: ''
    property bool hide: true
    id: flickable
    width: parent.width
    contentWidth: Math.max(parent.width,web_view.width)
    contentHeight: Math.max(parent.height,web_view.height)
    pressDelay: 200
    smooth: true

    signal next()
    signal previous()
    signal back()
    signal home()

    Keys.onPressed:{
        if(event.key == '17825793'){
            back()
        }
        if(event.key == '17825792'){
            home()
        }
    }

    Rectangle{
        anchors.fill: parent
        color: "#ffffff"
        opacity: web_view.opacity
    }

//    property int histx : 0
//    property int histy : 0

//    function resetTbar(){
//        menubar.x += contentX-histx
//        menubar.y += contentY-histy
//        histx = contentX
//        histy = contentY
//    }
//    onContentXChanged: resetTbar()
//    onContentYChanged: resetTbar()


    onFocusChanged: {
        if(activeFocus){
            web_view.forceActiveFocus()
        }

    }

    WebView {
        id: web_view
        x: 0;y: 0
        opacity:  hide?0.0:1.0
        clip: true
        preferredWidth: flickable.width
        preferredHeight: flickable.height
        html: "<style> body{font-size：12px;} img{max-width:"+(flickable.parent.width-20)+"px;} </style>"+content
        settings.javascriptEnabled: true
        settings.pluginsEnabled: true
        settings.localContentCanAccessRemoteUrls: true
        Behavior on opacity{NumberAnimation{duration: 200}}

        Keys.onDigit1Pressed:{
            web_view.contentsScale -= 0.1
        }
        Keys.onDigit3Pressed:{
            web_view.contentsScale += 0.1
        }


        Keys.onUpPressed:{
            if(!flickable.atYBeginning)
                flickable.contentY -= 5;
        }
        Keys.onDownPressed:{
            if(!flickable.atYEnd)
                flickable.contentY += 5;
        }

        Keys.onLeftPressed:{
           if(!flickable.atXBeginning)
                flickable.contentX -= 5;
        }
        Keys.onRightPressed:{
            if(!flickable.atXEnd)
                flickable.contentX += 5;
        }


    }


    Loading{
        id:loading
        anchors.fill: parent
        show: web_view.progress<1
    }

}
