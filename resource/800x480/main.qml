import Qt 4.7
import Openbossa 1.0

Rectangle {
    id: mainWindow
    width: 800
    height: 480
    color: "white"

    signal close();

    MobileWebView {
        id: browser
        anchors.top: toolbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        url: "http://www.google.com"

        onTitleChanged: mainbar.title = title;
        onUrlChanged: toolbar.setUrl(browser.url);

        onLoadFinished: {
            toolbar.loading = false;
            toolbar.progress = 1.0;
        }

        onLoadProgress: {
            toolbar.loading = true;
            toolbar.progress = progress / 100.0;
        }
    }

    MainBar {
        id: mainbar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Toolbar {
        id: toolbar
        anchors.top: mainbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        onBackClicked: browser.back();
        onStopClicked: browser.stop();
        onForwardClicked: browser.forward();
        onReloadClicked: browser.url = toolbar.url;
    }
}
