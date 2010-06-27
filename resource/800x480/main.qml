import Qt 4.7

Rectangle {
    id: mainWindow
    width: 800
    height: 480
    color: "#666666"

    signal close();
    signal resized();

    TabView {
        id: tabView
        anchors.top: toolbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        onUrlChanged: toolbar.setUrl(tabView.url);

        Connections {
            target: mainWindow
            onResized: tabView.updateSnapshots(true);
        }
    }

    MainBar {
        id: mainbar
        title: tabView.current.title
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Toolbar {
        id: toolbar
        visible: false
        opacity: 0.0
        anchors.top: mainbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        progress: tabView.current.progress
        loading: (tabView.current.progress < 1.0)

        onBackClicked: tabView.current.webview.back();
        onStopClicked: tabView.current.webview.stop();
        onForwardClicked: tabView.current.webview.forward();
        onReloadClicked: tabView.current.webview.url = toolbar.url;
        onOptionsClicked: tabView.state = "minimized";
    }
}
