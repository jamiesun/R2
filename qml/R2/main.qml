import Qt 4.7
import Utils 1.0
import "json2.js" as Json
Rectangle {
    id: mainApp
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
    property string teststr: "this is test"

    property string stateUrl: "https://www.google.com/reader/api/0/stream/contents/"

    function setCache(name,value){
        utils.setCache(Qt.md5(name),value)
    }

    function getCache(name){
        return utils.getCache(Qt.md5(name))
    }

    Image {id: name;anchors.fill:parent;source: "res/bg.jpg"}

    gradient: Gradient {
        GradientStop {position: 0;color: "#363636"}
        GradientStop {position: 1;color: "#000000"}
    }

    Keys.onPressed:{console.log(event.key)}


    Utils{id:utils}

    WorkerScript {
        id: unreadWork;source: "unread.js"
        onMessage: {
            if(messageObject.unreads){
                var tmp = JSON.parse(messageObject.unreads)['unreadcounts']
                if(tmp){
                    var urtmp = {}
                    for(var ikey in tmp){
                        var uit = tmp[ikey]
                        urtmp[Qt.md5(uit.id)] = uit.count
                    }
                    mainApp.unreads = urtmp
                }
            }
        }
    }

    WorkerScript {
        id: tokenWork; source: "token.js"
        onMessage: {
            if(messageObject.token){
                mainApp.token = messageObject.token
            }
            else{
                notice.show("token faild");
            }
        }
    }



    WorkerScript {
        id: authWork;source: "auth.js"
        onMessage: {
            if(messageObject.auth&&messageObject.sid){
                console.log("login success")
                mainApp.auth = messageObject.auth;
                mainApp.sid = messageObject.sid;
                tokenWork.sendMessage({auth:mainApp.auth,sid:mainApp.sid})
                unreadTimer.start()
            }
            else{
                notice.show(messageObject.msg);
            }
            taglist.updateModel()
            loading.show = false
        }
    }

    Timer {
        id:unreadTimer;triggeredOnStart:true
        interval: 1000*60*3; running: false; repeat: true
        onTriggered: unreadWork.sendMessage({auth:mainApp.auth,sid:mainApp.sid})
    }


    function initConfig(){
        var cfgstr = utils.safeRead(".config")
        if(cfgstr == ""){
            mainApp.state = "showSettings"
        }else{
            var cfgs = cfgstr.split(",")
            if(cfgs.length<3){
                console.log("error config")
                mainApp.state = "showSettings"
                return
            }
            mainApp.email = cfgs[0]
            mainApp.passwd = cfgs[1]
            mainApp.feedMax = cfgs[2]?cfgs[2]:"30"
            authWork.sendMessage({email:mainApp.email,passwd:mainApp.passwd});
            loading.show = true
        }
    }

    Component.onCompleted:initConfig()

    TagList {
        id: taglist;anchors.fill: parent;focus: true
        onItemClick: {
            if(tagname=="starred"||tagname=="broadcast"||tagname=="notes"){
                mainApp.state = "showFeedList2"
                feedlist.update(tagname,stateUrl+tagid)
            }else{
                mainApp.state = "showRsslist"
                rsslist.filter(tagname,tagid,mainApp.unreads)
                rsslist.forceActiveFocus()
            }
        }
        onDoSettings: mainApp.state = "showSettings"
        onDoNote:mainApp.state = "showNote"
    }

    RssList {
        id: rsslist;anchors.fill: parent;opacity: 0
        onBack:mainApp.state = "showMain"
        onItemClick: {
            mainApp.state = "showFeedList"
            feedlist.update(title,url)
        }
        onHome:mainApp.state = "showMain"
    }

    FeedList{
        id: feedlist;anchors.fill: parent;opacity: 0
        onBack:mainApp.state = "showRsslist"
        onItemClick: {
            mainApp.state = "showItem"
            feedDetail.update(feedlist.getCurrentObj())
        }
        onHome:mainApp.state = "showMain"
    }

    FeedDetail{
        id:feedDetail;opacity: 0;anchors.fill: parent
        hide:mainApp.state!="showItem"
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
            if(feedlist.title=="starred"||feedlist.title=="broadcast"||feedlist.title=="notes"){
                mainApp.state = "showFeedList2";
            }else{
                mainApp.state = "showFeedList";
            }
            loading.show = false
        }
        onHome:mainApp.state = "showMain"
        onSendmail:mainApp.state = "showSendmail"
        onDoComment:mainApp.state = "showComment"
        onSetMouse:utils.showMouse(isShow)
        onLoadStarted: loading.show = true
        onLoadFinished: loading.show = false
    }


    Settings{
        id:settings
        email: mainApp.email;passwd: mainApp.passwd;feedMax: mainApp.feedMax
        opacity: 0
        anchors.fill: parent
        onCancel:mainApp.state = "showMain"
        onSave: {
            utils.safeWrite(".config",cfgData)
            mainApp.state = "showMain"
            initConfig()
        }
    }

    SendMail{
        id:sendMail;opacity:0;anchors.fill:parent
        WorkerScript {
            id: mailWork;source: "sendmail.js"
            onMessage: notice.show(messageObject.msg)
        }
        onCancel:mainApp.state = "showItem"
        onSend:{
            mainApp.state = "showItem"
            var message = feedlist.getCurrentObj()
            var msg = {}
            msg.emailTo = mailto
            msg.comment = content
            msg.auth = message.auth
            msg.sid = message.sid
            msg.token = message.token
            msg.subject = message.title
            msg.entry = message.id
            msg.id = message.id
            mailWork.sendMessage(msg)
        }
    }

    Comment{
        id:comment;opacity:0;anchors.fill:parent
        WorkerScript {
            id: commentWork;source: "comment.js"
            onMessage: notice.show(messageObject.msg)
        }
        onCancel:mainApp.state = "showItem"
        onComment:{
            mainApp.state = "showItem"
            var message = feedlist.getCurrentObj()
            var msg = {
                auth:mainApp.auth,
                sid:mainApp.sid,
                token:mainApp.token,
                comment:content,
                snippet:message.content,
                srcTitle:message.srcTitle,
                srcUrl:message.srcUrl,
                title:message.title,
                url:message.url
            }
            commentWork.sendMessage(msg)
        }
    }

    Note{
        id:note;opacity:0;anchors.fill:parent
        WorkerScript {
            id: noteWork;source: "createnote.js"
            onMessage: notice.show(messageObject.msg)
        }
        onCancel: mainApp.state = "showMain"
        onCreateNote:{
            mainApp.state = "showMain"
            var msg = {snippet:content,auth:mainApp.auth,sid:mainApp.sid,token:mainApp.token}
            if(tags) msg.tags = tags
            noteWork.sendMessage(msg)
        }
    }

    Notice{id:notice;opacity:0; x:0;y:mainApp.height-notice.height}

    Loading{id:loading;anchors.fill: parent}

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
            PropertyChanges {target: feedlist;opacity: 0;onBack:mainApp.state="showRsslist"}
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
            PropertyChanges {target: feedlist;opacity: 1;focus:true;onBack:mainApp.state="showMain"}
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
        },
        State {
            name: "showSendmail"
            PropertyChanges {target: sendMail;opacity: 1;focus:true}
            PropertyChanges {target: feedDetail;opacity: 0}
            PropertyChanges {target: taglist;opacity: 0}
            PropertyChanges {target: feedlist;opacity: 0}
            PropertyChanges {target: rsslist;opacity: 0}
        },
        State {
            name: "showComment"
            PropertyChanges {target: comment;opacity: 1;focus:true}
            PropertyChanges {target: feedDetail;opacity: 0}
            PropertyChanges {target: taglist;opacity: 0}
            PropertyChanges {target: feedlist;opacity: 0}
            PropertyChanges {target: rsslist;opacity: 0}
        },
        State {
            name: "showNote"
            PropertyChanges {target: note;opacity: 1;focus:true}
            PropertyChanges {target: taglist;opacity: 0}
        }


    ]
}
