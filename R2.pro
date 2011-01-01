# Add more folders to ship with the application, here
folder_01.source = qml/R2
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =
QT +=  webkit network
# Avoid auto screen rotation
#DEFINES += ORIENTATIONLOCK

# Needs to be defined for Symbian
DEFINES += NETWORKACCESS

symbian:{
    TARGET.UID3 = 0xEA2FC102
    TARGET.EPOCHEAPSIZE = 0x200000 0x2000000
    ICON = MyReader.svg
}

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    utils.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

RESOURCES +=

HEADERS += \
    utils.h

OTHER_FILES += \
    qml/R2/models/TagsModel.qml \
    qml/R2/models/RssModel.qml \
    qml/R2/models/FeedModel.qml \
    qml/R2/ToolBar.qml \
    qml/R2/template.qml \
    qml/R2/TagList.qml \
    qml/R2/TagItem.qml \
    qml/R2/Settings.qml \
    qml/R2/RssToolBar.qml \
    qml/R2/RssList.qml \
    qml/R2/RssItem.qml \
    qml/R2/MenuBar.qml \
    qml/R2/main.qml \
    qml/R2/Loading.qml \
    qml/R2/json2.js \
    qml/R2/FeedList.qml \
    qml/R2/FeedItem.qml \
    qml/R2/FeedDetail.qml \
    qml/R2/cache.js \
    qml/R2/Button.qml \
    qml/R2/auth.js \
    qml/R2/Alert.qml \
    R2.png \
    R2.svg \
    qml/R2/edittag.js \
    qml/R2/token.js \
    qml/R2/res/logo.png \
    qml/R2/res/bg.jpg \
    qml/R2/res/16/zoom.png \
    qml/R2/res/16/wrench.png \
    qml/R2/res/16/wrench_plus_2.png \
    qml/R2/res/16/users.png \
    qml/R2/res/16/user.png \
    qml/R2/res/16/undo.png \
    qml/R2/res/16/twitter.png \
    qml/R2/res/16/twitter_2.png \
    qml/R2/res/16/trash.png \
    qml/R2/res/16/tag.png \
    qml/R2/res/16/star_fav.png \
    qml/R2/res/16/star_fav_empty.png \
    qml/R2/res/16/sq_plus.png \
    qml/R2/res/16/sq_minus.png \
    qml/R2/res/16/sq_br_down.png \
    qml/R2/res/16/spechbubble.png \
    qml/R2/res/16/spechbubble_sq.png \
    qml/R2/res/16/spechbubble_sq_line.png \
    qml/R2/res/16/spechbubble_2.png \
    qml/R2/res/16/share.png \
    qml/R2/res/16/save.png \
    qml/R2/res/16/rss.png \
    qml/R2/res/16/rss_sq.png \
    qml/R2/res/16/round_plus.png \
    qml/R2/res/16/round_minus.png \
    qml/R2/res/16/round_delete.png \
    qml/R2/res/16/round_checkmark.png \
    qml/R2/res/16/round_and_up.png \
    qml/R2/res/16/redo.png \
    qml/R2/res/16/playback_reload.png \
    qml/R2/res/16/picture.png \
    qml/R2/res/16/photo.png \
    qml/R2/res/16/phone.png \
    qml/R2/res/16/pencil.png \
    qml/R2/res/16/padlock_open.png \
    qml/R2/res/16/padlock_closed.png \
    qml/R2/res/16/on-off.png \
    qml/R2/res/16/notepad.png \
    qml/R2/res/16/notepad_2.png \
    qml/R2/res/16/mail.png \
    qml/R2/res/16/mail_2.png \
    qml/R2/res/16/home.png \
    qml/R2/res/16/heart.png \
    qml/R2/res/16/heart_empty.png \
    qml/R2/res/16/hand_pro.png \
    qml/R2/res/16/hand_contra.png \
    qml/R2/res/16/folder.png \
    qml/R2/res/16/folder_arrow.png \
    qml/R2/res/16/emotion_smile.png \
    qml/R2/res/16/emotion_sad.png \
    qml/R2/res/16/download.png \
    qml/R2/res/16/document.png \
    qml/R2/res/16/doc_plus.png \
    qml/R2/res/16/doc_new.png \
    qml/R2/res/16/doc_minus.png \
    qml/R2/res/16/doc_lines.png \
    qml/R2/res/16/doc_lines_stright.png \
    qml/R2/res/16/doc_empty.png \
    qml/R2/res/16/doc_edit.png \
    qml/R2/res/16/doc_delete.png \
    qml/R2/res/16/delete.png \
    qml/R2/res/16/contact_card.png \
    qml/R2/res/16/checkmark.png \
    qml/R2/res/16/checkbox_unchecked.png \
    qml/R2/res/16/checkbox_checked.png \
    qml/R2/res/16/cancel.png \
    qml/R2/res/16/calendar_2.png \
    qml/R2/res/16/calendar_1.png \
    qml/R2/res/16/br_up.png \
    qml/R2/res/16/br_prev.png \
    qml/R2/res/16/br_next.png \
    qml/R2/res/16/br_down.png \
    qml/R2/res/16/bookmark_2.png \
    qml/R2/res/16/bookmark_1.png \
    qml/R2/res/16/book.png \
    qml/R2/res/16/attention.png \
    qml/R2/res/16/arrow_top.png \
    qml/R2/res/16/arrow_right.png \
    qml/R2/res/16/arrow_left.png \
    qml/R2/res/16/arrow_bottom.png \
    qml/R2/res/16/app_window.png \
    qml/R2/unread.js \
    qml/R2/MenuItem.qml \
    qml/R2/FeedMenu.qml \
    qml/R2/res/toolbutton.sci \
    qml/R2/res/toolbutton.png \
    qml/R2/res/titlebar.sci \
    qml/R2/res/titlebar.png \
    qml/R2/res/loading.gif \
    qml/R2/FeedView.qml \
    qml/R2/PhotoView.qml \
    qml/R2/res/photo.png \
    qml/R2/FeedDetailS.qml \
    qml/R2/res/16/sound_low.png \
    qml/R2/res/16/sound_high.png \
    qml/R2/res/16/round_arrow_right.png \
    qml/R2/res/16/round_arrow_left.png \
    qml/R2/res/16/eye.png \
    qml/R2/res/16/eye_inv.png \
    qml/R2/SendMail.qml \
    qml/R2/sendmail.js \
    qml/R2/Comment.qml \
    qml/R2/createnote.js \
    qml/R2/comment.js \
    qml/R2/Note.qml \
    qml/R2/FeedToolBar.qml \
    qml/R2/Notice.qml
