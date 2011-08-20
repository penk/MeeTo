import Qt 4.7
import MeeTo 1.0

Item {
    id: tabViewItem

    FlickableWebView {
        id: webView
        url: webBrowser.urlString
        onProgressChanged: header.urlChanged = false
        anchors { top: headerSpace.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }
    }

}
