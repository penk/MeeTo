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

    function getHostname(str) {
        var re = new RegExp('^http(?:s)?\://([^/]+)', 'im');
        var text = str.match(re)[0].toString();
	    return text.replace(/(http|https)\:\/\//i, "").toString();
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            listview.currentIndex = index;
            tabViewItem.clicked();
        }
    }

    Rectangle {
        id: snapshot
        smooth: true
        color: "white"
        width: tabViewItem.width
        height: tabViewItem.height

        PixmapItem {
            id: snapshotPicture
            visible: deletable
            smooth: true
            anchors.fill: parent
            pixmap: model.snapshot
        }

        Image {
            source: ":images/new_page.png"
            visible: !deletable
            anchors.fill: parent
            anchors.rightMargin: -1
        }

        Text {
            anchors.top: parent.bottom;
            anchors.topMargin: 6;
            font.family: "Helvetica";
            font.pointSize: 12;
            text: getHostname(url);
            color: "white";
            anchors.horizontalCenter: parent.horizontalCenter
        }


        Image {
            source: ":images/bt_browser_close.png"
            visible: deletable
            anchors.right: parent.left
            anchors.bottom: parent.top
            anchors.rightMargin: -15
            anchors.bottomMargin: -15
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
        onLoadFinished: {
            tabViewItem.progress = 1.0;
            toolbar.setUrl(browser.url);
        }

        onUrlChanged: {
            initialized = true;
            tabModel.setUrl(index, browser.url);
            if (index == tabModel.count - 1)
                tabViewItem.newTabRequest();
        }
    }
}
