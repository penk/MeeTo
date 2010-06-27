import Qt 4.7
import Openbossa 1.0

Item {
    id: tabViewItem

    signal clicked();
    signal removeClicked();
    signal newTabRequest();

    property bool deletable : true
    property bool initialized : false
    property variant webview : browser
    property variant websnap : snapshot

    property string url : model.url
    property string title : model.title
    property real progress : 0.0

    Connections {
        target: tabView
        onUpdateSnapshots: {
            if (initialized || force)
                tabModel.setSnapshot(index, webview.snapshot(webview.width,
                                            webview.height + spareHeight));
        }
    }

    function reopen() {
        if (!initialized && model.url != "")
            webview.url = model.url;
    }

    MouseArea {
        anchors.fill: parent
        onClicked: tabViewItem.clicked();
    }

    BorderImage {
        border.left: 50
        border.right: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom
        source: ":images/shadow_pic.png"
    }

    Rectangle {
        id: snapshot
        smooth: true
        color: "white"
        width: tabViewItem.width
        height: tabViewItem.height

        Image {
            id: snapshotPicture
            smooth: true
            anchors.fill: parent
            pixmap: model.snapshot
        }

        Image {
            source: ":images/bt_browser_close.png"
            visible: deletable
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: -20
            anchors.bottomMargin: -20
            MouseArea {
                anchors.fill: parent
                onClicked: tabViewItem.removeClicked();
            }
        }
    }

    MobileWebView {
        id: browser
        frozen: true
        visible: false
        width: tabOverlay.width
        height: tabOverlay.height

        onTitleChanged: tabModel.setTitle(index, title);
        onLoadProgress: tabViewItem.progress = progress / 100.0;
        onLoadFinished: tabViewItem.progress = 1.0;

        onUrlChanged: {
            initialized = true;
            tabModel.setUrl(index, browser.url);
            if (index == tabModel.count - 1)
                tabViewItem.newTabRequest();
        }
    }
}
