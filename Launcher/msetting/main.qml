import Qt 4.7
import QtWebKit 1.0

Flickable {

    width: 1024
    height: 600

    contentWidth: webView.width
    contentHeight: webView.height

    WebView {
        id: webView
        preferredWidth: 1024 
        preferredHeight: 600
        url: 'http://localhost'
    }
}

