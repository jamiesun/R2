import Qt 4.7
import Utils 1.0
Rectangle {
    id: main
    width: 320
    height: 240
    property string email: ""
    property string passwd: ""
    property string auth: ''
    property string sid: ''
    property string feedMax: "100"
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#363636"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }

    Keys.onPressed:console.log(event.key)

    Utils{id:utils}

    WorkerScript {
        id: authWork
        source: "auth.js"
        onMessage: {
            if(messageObject.auth&&messageObject.sid){
                console.log("login success")
                main.auth = messageObject.auth;
                main.sid = messageObject.sid;
                taglist.updateModel(main.auth,main.sid)
            }
            else{
                console.log("login faild");
            }
            loading.show = false

        }
    }

    function initConfig(){
        var cfgstr = utils.safeRead(".config")
        if(cfgstr == ""){
            main.state = "settings"
        }else{
            var cfgs = cfgstr.split(",")
            main.email = cfgs[0]
            main.passwd = cfgs[1]
            main.feedMax = cfgs[2]?cfgs[2]:"100"
            authWork.sendMessage({email:main.email,passwd:main.passwd});
            loading.show = true
            console.log(main.email);
        }
    }

    Component.onCompleted:initConfig()

    TagList {
        id: taglist
        anchors.fill: parent
        focus: true
        onItemClick: {
            main.state = "showRsslist"
            rsslist.filter(tag)
            rsslist.forceActiveFocus()
        }
    }

    RssList {
        id: rsslist;auth: main.auth;sid: main.sid
        anchors.fill: parent
        opacity: 0
        onBack:main.state = "showMain"
        onItemClick: {
            main.state = "showFeedList"
            feedlist.update(title,url)
        }
    }

    FeedList{
        id: feedlist;auth: main.auth;sid: main.sid
        anchors.fill: parent
        opacity: 0
        onBack:main.state = "showRsslist"
        onItemClick: {
            main.state = "showItem"
            feedDetail.content = content
        }
    }

    FeedDetail{
        id:feedDetail
        hide:main.state!="showItem"
        anchors.fill: parent
        onPrevious: content = itemFeeds.previous()
        onNext: content = itemFeeds.next()
        onBack: main.state = "showFeedList";
    }

    Loading{
        id:loading
        anchors.fill: parent
        show: rssModel.busy
    }

    states: [
        State {
            name: "showRsslist"
            PropertyChanges {target: taglist;opacity: 0}
            PropertyChanges {target: rsslist;opacity: 1;focus:true}
        },
        State {
            name: "showMain"
            PropertyChanges {target: taglist;opacity: 1;focus:true}
            PropertyChanges {target: rsslist;opacity: 0}
        },
        State {
            name: "showFeedList"
            PropertyChanges {target: feedlist;opacity: 1;focus:true}
            PropertyChanges {target: rsslist;opacity: 0}
        },
        State {
            name: "showItem"
            PropertyChanges {target: feedDetail;opacity: 1;focus:true}
            PropertyChanges {target: feedlist;opacity: 0}
        }


    ]
}
