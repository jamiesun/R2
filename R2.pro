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
    qml/R2/IMenuBar.qml \
    qml/R2/FeedList.qml \
    qml/R2/FeedItem.qml \
    qml/R2/FeedDetail.qml \
    qml/R2/cache.js \
    qml/R2/Button.qml \
    qml/R2/auth.js \
    qml/R2/Alert.qml \
    qml/R2/pics/wifi_64.png \
    qml/R2/pics/wifi_48.png \
    qml/R2/pics/wifi_24.png \
    qml/R2/pics/video_play_64.png \
    qml/R2/pics/video_play_24.png \
    qml/R2/pics/toolbutton.sci \
    qml/R2/pics/toolbutton.png \
    qml/R2/pics/titlebar.sci \
    qml/R2/pics/titlebar.png \
    qml/R2/pics/tag_remove_64.png \
    qml/R2/pics/tag_remove_48.png \
    qml/R2/pics/tag_remove_24.png \
    qml/R2/pics/tag_add_64.png \
    qml/R2/pics/tag_add_48.png \
    qml/R2/pics/tag_add_24.png \
    qml/R2/pics/tag_64.png \
    qml/R2/pics/tag_48.png \
    qml/R2/pics/tag_24.png \
    qml/R2/pics/spanner_64.png \
    qml/R2/pics/spanner_48.png \
    qml/R2/pics/spanner_24.png \
    qml/R2/pics/rss_64.png \
    qml/R2/pics/rss_48.png \
    qml/R2/pics/rss_24.png \
    qml/R2/pics/plus_64.png \
    qml/R2/pics/plus_48.png \
    qml/R2/pics/plus_24.png \
    qml/R2/pics/minus_64.png \
    qml/R2/pics/minus_48.png \
    qml/R2/pics/minus_24.png \
    qml/R2/pics/loading.gif \
    qml/R2/pics/lineedit.sci \
    qml/R2/pics/lineedit.png \
    R2.png \
    R2.svg \
    qml/R2/pics/reload_64.png \
    qml/R2/pics/reload_48.png \
    qml/R2/pics/reload_24.png \
    qml/R2/pics/R2.png \
    qml/R2/pics/magnifier_64.png \
    qml/R2/pics/magnifier_48.png \
    qml/R2/pics/magnifier_24.png \
    qml/R2/pics/document_64.png \
    qml/R2/pics/document_48.png \
    qml/R2/pics/document_24.png \
    qml/R2/edittag.js \
    qml/R2/token.js
