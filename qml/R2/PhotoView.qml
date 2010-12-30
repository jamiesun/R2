
import Qt 4.7

Rectangle {
    id:photoview
    color: "#272727"
    Behavior on opacity{NumberAnimation{duration: 200}}
    signal close()

    function update(images){
        viewModel.clear()
        for(var k in images){
            viewModel.append({imgsrc:images[k]})
        }
        console.log("totle photo:"+images.length)
    }

    function show(){
        opacity = 1
        view.forceActiveFocus()
    }

    function hide(){
        opacity = 0
        focus = false
    }

    onFocusChanged: {
        if(activeFocus){
            view.forceActiveFocus()
        }
    }



    ListView {
        id: view
        x:0;y:0
        width: photoview.width;height: photoview.height
        model:ListModel {id: viewModel}
        preferredHighlightBegin: 0; preferredHighlightEnd: 0
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem; flickDeceleration: 2000
        delegate: Item {
            anchors.fill: parent
            property alias imgStatus: image1.status
            Image {
            id: image1
            asynchronous: true
            source: imgsrc
            x:(parent.width-image1.width)/2
            y:(parent.height-image1.height)/2
            onStatusChanged: {
                console.log("image.status:"+image1.status)
                console.log("null="+Image.Null)
                console.log("loading="+Image.Loading)
                console.log("ready="+Image.Ready)
                console.log("error="+Image.Error)
                if(image1.status==Image.Ready){
                    var w = image1.width
                    var h = image1.height
                    var nw = view.width>w?w:view.width
                    var nh = h*(nw/w)
                    image1.width = nw
                    image1.height = nh
                    console.log("w="+w+" h="+h+" nw="+nw+" nh+"+nh)
                }
            }

          }

        }

        Keys.onSelectPressed:close()
        Keys.onLeftPressed:view.decrementCurrentIndex()
        Keys.onRightPressed:view.incrementCurrentIndex()
        Keys.onUpPressed:view.decrementCurrentIndex()
        Keys.onDownPressed:view.incrementCurrentIndex()
    }

    Text {
        text: "Image Unavailable"
        visible: view.currentItem.imgStatus == Image.Error
        anchors.centerIn: parent; color: "white"; font.bold: true
    }
    Loading{
        id:loading
        show: view.currentItem.imgStatus == Image.Loading
        anchors.fill: parent
    }




}
