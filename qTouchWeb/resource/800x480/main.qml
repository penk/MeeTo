import Qt 4.7
//import Qt.labs.gestures 2.0

Rectangle {
    id: mainWindow
    width: 1024
    height: 768
    color: "black"

    signal resized();

/*
    GestureArea { 
        anchors.fill: parent;        
        Tap { 
            onStarted: console.log("tap started");
            onFinished: console.log("tap completed"); 
        }

    }
*/

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

    Toolbar {
        id: toolbar
        visible: false
        opacity: 0.0
        anchors.top: parent.top
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
