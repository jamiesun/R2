import Qt 4.7
import QtWebKit 1.0
Flickable {
    property bool hide: true
    id: flickable
    width: parent.width
    contentWidth: Math.max(parent.width,web_view.width)
    contentHeight: Math.max(parent.height,web_view.height)
    pressDelay: 200
    smooth: true

    Behavior on contentY{NumberAnimation{duration: 300}}

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

    function setContent(content){
        web_view.html = "<style> body{font-size：12px;} img{max-width:"+(flickable.parent.width-20)+"px;} </style>"+content
        //web_view.evaluateJavaScript("location.reload();")
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
        settings.javascriptEnabled: true
        settings.pluginsEnabled: true
        renderingEnabled: true
        settings.privateBrowsingEnabled: true
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
                flickable.contentY -= 40;
        }
        Keys.onDownPressed:{
            if(!flickable.atYEnd)
                flickable.contentY += 40;
        }

        Keys.onLeftPressed:{
            flickable.previous()
        }
        Keys.onRightPressed:{
            flickable.next()
        }





    }


    Loading{
        id:loading
        anchors.fill: parent
        show: web_view.progress<1
    }

}
