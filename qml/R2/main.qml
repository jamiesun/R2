import Qt 4.7
import Utils 1.0
import "json2.js" as Json
Rectangle {
    id: main
    width: 320
    height: 240
    focus: true
    property string email: ""
    property string passwd: ""
    property string auth: ''
    property string sid: ''
    property string token: ''
    property string feedMax: "30"
    property variant unreads: {}

    property string stateUrl: "https://www.google.com/reader/api/0/stream/contents/user/-/state/com.google/"

    Image {
        id: name
        source: "res/bg.jpg"
    }

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

    Keys.onPressed:{
        console.log(event.key)
    }

    Utils{id:utils}

    WorkerScript {
        id: unreadWork
        source: "unread.js"
        onMessage: {
            if(messageObject.unreads){
                console.log("unread success")
                var tmp = JSON.parse(messageObject.unreads)['unreadcounts']
                if(tmp){
                    var urtmp = {}
                    for(var ikey in tmp){
                        var uit = tmp[ikey]
                        urtmp[Qt.md5(uit.id)] = uit.count
                    }
                    main.unreads = urtmp
                }

            }
            else{
                console.log("unread faild");
            }
        }
    }

    WorkerScript {
        id: tokenWork
        source: "token.js"
        onMessage: {
            if(messageObject.token){
                console.log("token success")
                main.token = messageObject.token
            }
            else{
                console.log("token faild");
            }
        }
    }

    WorkerScript {
        id: authWork
        source: "auth.js"
        onMessage: {
            if(messageObject.auth&&messageObject.sid){
                console.log("login success")
                main.auth = messageObject.auth;
                main.sid = messageObject.sid;
                tokenWork.sendMessage({auth:main.auth,sid:main.sid})
                unreadTimer.start()
                taglist.updateModel(main.auth,main.sid)
            }
            else{
                console.log("login faild");
            }
            loading.show = false

        }
    }

    Timer {
        id:unreadTimer;triggeredOnStart:true
        interval: 1000*60*3; running: false; repeat: true
        onTriggered: unreadWork.sendMessage({auth:main.auth,sid:main.sid})
    }

    function initConfig(){
        var cfgstr = utils.safeRead(".config")
        if(cfgstr == ""){
            main.state = "showSettings"
        }else{
            var cfgs = cfgstr.split(",")
            if(cfgs.length<3){
                console.log("error config")
                main.state = "showSettings"
                return
            }
            main.email = cfgs[0]
            main.passwd = cfgs[1]
            main.feedMax = cfgs[2]?cfgs[2]:"30"
            authWork.sendMessage({email:main.email,passwd:main.passwd});
            loading.show = true
        }
    }

    Component.onCompleted:initConfig()

    TagList {
        id: taglist;auth:main.auth;sid:main.sid;
        anchors.fill: parent
        focus: true
        onItemClick: {
            if(tag=="starred"||tag=="broadcast"||tag=="created"){
                main.state = "showFeedList2"
                feedlist.update(tag,stateUrl+tag)
            }else{
                main.state = "showRsslist"
                rsslist.filter(tag,main.unreads)
                rsslist.forceActiveFocus()
            }
        }
        onDoSettings: main.state = "showSettings"
    }

    RssList {
        id: rsslist;auth:main.auth;sid:main.sid;
        anchors.fill: parent
        opacity: 0
        onBack:main.state = "showMain"
        onItemClick: {
            main.state = "showFeedList"
            feedlist.update(title,url)
        }
        onHome:main.state = "showMain"
    }

    FeedList{
        id: feedlist;auth:main.auth;sid:main.sid;token:main.token
        anchors.fill: parent
        opacity: 0
        onBack:main.state = "showRsslist"
        onItemClick: {
            main.state = "showItem"
            feedDetail.update(feedlist.getCurrentObj())
        }
        onHome:main.state = "showMain"
    }

    FeedDetail{
        id:feedDetail
        opacity: 0
        hide:main.state!="showItem"
        anchors.fill: parent
        onPrevious: {
            feedlist.previous()
            feedDetail.update(feedlist.getCurrentObj())
        }

        onNext: {
            feedlist.next()
            feedDetail.update(feedlist.getCurrentObj())
        }

        onModelChanged: {
            feedlist.setCurrentObj(obj)
        }

        onBack: {
            if(feedlist.title=="starred"||feedlist.title=="broadcast"||feedlist.title=="created"){
                main.state = "showFeedList2";
            }else{
                main.state = "showFeedList";
            }
        }
        onHome:main.state = "showMain"
    }

    Settings{
        id:settings
        email: main.email;passwd: main.passwd;feedMax: main.feedMax
        opacity: 0
        anchors.fill: parent
        onCancel:main.state = "showMain"
        onSave: {
            utils.safeWrite(".config",cfgData)
            main.state = "showMain"
        }
    }



    Loading{
        id:loading
        anchors.fill: parent
    }

    states: [
        State {
            name: "showRsslist"
            PropertyChanges {target: taglist;opacity: 0}
            PropertyChanges {target: rsslist;opacity: 1;focus:true}
            PropertyChanges {target: feedlist;opacity: 0}
        },
        State {
            name: "showMain"
            PropertyChanges {target: taglist;opacity: 1;focus:true}
            PropertyChanges {target: rsslist;opacity: 0}
            PropertyChanges {target: settings;opacity: 0}
            PropertyChanges {target: feedlist;opacity: 0;onBack:main.state="showRsslist"}
        },
        State {
            name: "showFeedList"
            PropertyChanges {target: feedlist;opacity: 1;focus:true}
            PropertyChanges {target: rsslist;opacity: 0}
            PropertyChanges {target: taglist;opacity: 0}
            PropertyChanges {target: settings;opacity: 0}
        },
        State {
            name: "showFeedList2"
            PropertyChanges {target: feedlist;opacity: 1;focus:true;onBack:main.state="showMain"}
            PropertyChanges {target: rsslist;opacity: 0}
            PropertyChanges {target: taglist;opacity: 0}
            PropertyChanges {target: settings;opacity: 0}
        },
        State {
            name: "showItem"
            PropertyChanges {target: feedDetail;opacity: 1;focus:true}
            PropertyChanges {target: feedlist;opacity: 0}
            PropertyChanges {target: rsslist;opacity: 0}
            PropertyChanges {target: taglist;opacity: 0}
            PropertyChanges {target: settings;opacity: 0}
        },
        State {
            name: "showSettings"
            PropertyChanges {target: settings;opacity: 1;focus:true}
            PropertyChanges {target: taglist;opacity: 0}
            PropertyChanges {target: feedlist;opacity: 0}
            PropertyChanges {target: rsslist;opacity: 0}
        }


    ]
}
