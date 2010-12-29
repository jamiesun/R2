import Qt 4.7
Rectangle {
    id:feed_view
    radius: 10
    width: parent.parent.width-10
    height: Math.max(parent.parent.height,(photo_.height+content_.height+30))
    property alias content: content_.text
    property bool hasImage: false

    Behavior on opacity{NumberAnimation{duration: 200}}
    signal photoChicked()

    Keys.onSelectPressed:photoChicked()

    Image {
        id: photo_
        opacity:feed_view.activeFocus?1:0.7
        x: 8
        y: hasImage?8:0
        width:hasImage?64:0;height:hasImage?64:0
        source: "res/photo.png"

    }

    Text {
        id: content_
        smooth:true
        x: 5;y: photo_.height+photo_.y+8
        width: feed_view.width-10
        color: "#000000"
        text: ""
        clip: false
        textFormat:Text.RichText
        font.pointSize: 8
        wrapMode: TextEdit.WordWrap
    }


}
