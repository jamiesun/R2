
import Qt 4.7

Rectangle {
    id:photoview
    color: "#272727"
    Behavior on opacity{NumberAnimation{duration: 200}}
    signal close()
    property int cindex: 0

    function update(images){
        viewModel.clear()
        cindex =0
        for(var k in images){
            viewModel.append({imgsrc:images[k]})
        }
        currImg.source =  mainApp.getImagePath(viewModel.get(cindex).imgsrc)
        console.log("totle photo:"+images.length)
    }

    function previous(){
        if(cindex>0){
            cindex -=1
            currImg.source =  mainApp.getImagePath(viewModel.get(cindex).imgsrc)
        }
    }

    function next(){
        if(cindex<(viewModel.count-1)){
             cindex +=1
        }
        currImg.source =  mainApp.getImagePath(viewModel.get(cindex).imgsrc)
    }

    function show(){
        opacity = 1
        currImg.forceActiveFocus()
    }

    function hide(){
        opacity = 0
        focus = false
    }

    onFocusChanged: {
        if(activeFocus){
            currImg.forceActiveFocus()
        }
    }

    ListModel {id: viewModel}


    Image {
        id: currImg
        asynchronous: true
        fillMode: Image.PreserveAspectFit
        onStatusChanged: {
            if(currImg.status==Image.Ready){
                width=Math.min(currImg.width,parent.width)
                height=Math.min(currImg.height,parent.height)
                x=(parent.width-currImg.width)/2
                y=(parent.height-currImg.height)/2
            }
        }

        Keys.onSelectPressed:close()
        Keys.onLeftPressed:previous()
        Keys.onRightPressed:next()
        Keys.onUpPressed:previous()
        Keys.onDownPressed:next()
    }






    Text {
        text: "Image Unavailable"
        visible: currImg.status == Image.Error
        anchors.centerIn: parent; color: "white"; font.bold: true
    }
    Loading{
        id:loading
        show: currImg.status == Image.Loading
        anchors.fill: parent
    }




}
