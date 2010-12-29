
import Qt 4.7

Rectangle {
    id:photoview
    color: "#272727"
    Behavior on opacity{NumberAnimation{duration: 200}}
    signal close()


    function update(images){
        itemModel.clear()
        for(var k in images){
            itemModel.append({src:images[k]})
        }

    }

    onFocusChanged: {
        if(activeFocus){
            view.forceActiveFocus()
        }
    }

    ListModel {
        id: itemModel
    }

    ListView {
        id: view
        x:0;y:0
        width: photoview.width;height: photoview.height
        model: itemModel
        preferredHighlightBegin: 0; preferredHighlightEnd: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem; flickDeceleration: 2000
        delegate: Image {
            id: image1
            asynchronous: true
            source: src
            onStatusChanged: {
                loading.show=(image1.status==Image.Loading)
                if(image1.status==Image.Ready){
                    var w = image1.width
                    var h = image1.height
                    var nw = view.width>w?w:view.width
                    var nh = h*(nw/w)

                    if(nh<view.height){
                        image1.y = (view.height-nh)/2
                    }


                    image1.width = nw
                    image1.height = nh

                }
            }
        }
        Keys.onSelectPressed:close()


    }
    Loading{
        id:loading
        anchors.fill: parent
    }


}
