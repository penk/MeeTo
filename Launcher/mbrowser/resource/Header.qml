import QtQuick 1.0

Image {
    id: header

    property alias editUrl: urlInput.text
    property bool urlChanged: false

    source: "images/toolbar.png"; 
    fillMode: Image.TileHorizontally

        function fixUrl(url)
        {
            console.log("fixUrl" + url);
            
            if (url == "") return url
            if (url[0] == "/") { console.log("started with / "); return "file://"+url; }
            if (url.indexOf(":")<0) {
/*
                if (url.indexOf(".")<0 || url.indexOf(" ")>=0) {
                    // Fall back to a search engine; hard-code Wikipedia
                    return "http://en.wikipedia.org/w/index.php?search="+url
                } else {
*/
                    console.log("not started with :");
                    return "http://"+url;
//                }
            }
            //return url
        }

//    x: webView.contentX < 0 ? -webView.contentX : webView.contentX > webView.contentWidth-webView.width
//       ? -webView.contentX+webView.contentWidth-webView.width : 0

    x: 0 // header doesn't move 
    y: {
        if (webView.progress < 1.0)
            return 0;
        else {
            webView.contentY < 0 ? -webView.contentY : webView.contentY > height ? -height : -webView.contentY
        }
    }
    Column {
        width: parent.width


        Item {
            width: parent.width; height: 20
            Text {
                anchors.centerIn: parent
                text: webView.title; font.pixelSize: 13; font.bold: true
                color: "#444A5C";
            }
            MouseArea {
                anchors.fill: parent;
                onClicked: webView.contentY = 0;
            }
        }


        Item {
            width: parent.width; height: 34

            Image {
                id: indicator
                source: "images/UIButtonBarPressedIndicator.png"
                visible: false
                z: 2
            }

            Image {
                id: backButton
                width: 48; height: parent.height
                source: "images/back.png"
                anchors { left: parent.left; bottom: parent.bottom }
                opacity: webView.back.enabled ? 1.0 : 0.4

                MouseArea {
                    anchors { fill: parent; margins: -10; }
                    onPressed: if (parent.opacity == 1) 
                        { indicator.visible = true; indicator.x = -25; indicator.y = -35; } 
                    onReleased: { indicator.visible = false; } 
                    onClicked: { webView.back.trigger(); }
                }
            }

            Image {
                id: nextButton
                width: 48; height: parent.height
                anchors.left: backButton.right
                source: "images/forward.png"
                opacity: webView.forward.enabled ? 1.0 : 0.4

                MouseArea {
                    anchors { fill: parent; margins: -10; }
                    onPressed: if (parent.opacity == 1) 
                        { indicator.visible = true; indicator.x = 23; indicator.y = -35; } 
                    onReleased: { indicator.visible = false; } 
                    onClicked: { webView.forward.trigger(); }
                }

            }

            Image {
                id: tabButton
                width: 48; height: parent.height
                anchors.left: nextButton.right
                source: "images/tab.png"

                MouseArea {
                    anchors { fill: parent; margins: -10; }
                    onPressed: if (parent.opacity == 1) 
                        { indicator.visible = true; indicator.x = 71; indicator.y = -35; } 
                    onReleased: { indicator.visible = false; } 
                    onClicked: { }
                }
            }

            Image {
                id: bookmarkButton
                width: 48; height: parent.height
                anchors.left: tabButton.right
                source: "images/bookmark.png"

                MouseArea {
                    anchors { fill: parent; margins: -10; }
                    onPressed: if (parent.opacity == 1) 
                        { indicator.visible = true; indicator.x = 119; indicator.y = -35; } 
                    onReleased: { indicator.visible = false; } 
                    onClicked: {  }
                }
            }

            Image {
                id: addButton
                width: 48; height: parent.height
                anchors.left: bookmarkButton.right
                source: "images/add.png"

                MouseArea {
                    anchors { fill: parent; margins: -10; }
                    onPressed: if (parent.opacity == 1) 
                        { indicator.visible = true; indicator.x = 167; indicator.y = -35; } 
                    onReleased: { indicator.visible = false; } 
                    onClicked: { frame.state = "TopUp";  }
                }
            }

            UrlInput {
                id: urlInput
                anchors { left: addButton.right; right: search.left; rightMargin: 10 }
                image: if (frame.state == "TopUp" || frame.state == "TopDown") { 
                            return "images/inputtext_portrait.png" } else { return "images/inputtext.png" } 
                onUrlEntered: {
                    webBrowser.urlString = fixUrl(url)
                    webBrowser.focus = true
                    header.urlChanged = false
                }
                onUrlChanged: header.urlChanged = true
            }

            Image {
                id: reloadButton
                anchors { right: urlInput.right; verticalCenter: parent.verticalCenter}
                source: "images/bt_browser_reload.png" 
                visible: webView.progress == 1.0 && !header.urlChanged && !urlInput.url.focus

                MouseArea {
                    anchors { fill: parent; margins: -10; } 
                    onClicked: { webView.reload.trigger(); }
                }
            }

            Image {
                id: stopButton
                anchors { right: urlInput.right; verticalCenter: parent.verticalCenter}
                source: "images/bt_browser_stop.png" 
                visible: webView.progress < 1.0 && !header.urlChanged 

                MouseArea {
                    anchors { fill: parent; margins: -10; } 
                    onClicked: { webView.stop.trigger(); }
                }
            }

            Image {
                id: clearButton
                anchors { right: urlInput.right; verticalCenter: parent.verticalCenter}
                source: "images/bt_browser_clear.png" 
                visible: urlInput.url.focus

                MouseArea {
                    anchors { fill: parent; margins: -10; } 
                    onClicked: { editUrl = ""; }
                }
            }

            BorderImage {
                id: search
                anchors { right: parent.right; rightMargin: 10; leftMargin: 10 }
                source: 
                        if (frame.state == "TopUp" || frame.state == "TopDown") { 
                            searchInput.focus ? "images/searchbox_ext_portrait.png" : "images/searchbox_portrait.png"; } 
                else { return searchInput.focus ? "images/searchbox_ext.png" : "images/searchbox.png"; } 

                TextInput {
                    id: searchInput
                    text: ""
                    anchors { fill: parent; margins: 6; leftMargin: 35; verticalCenter: parent.verticalCenter; topMargin: 10}
                    color: "#646464";

                    MouseArea {
                        anchors.fill: parent;
                        anchors.margins: -15;
                        onClicked: parent.focus = true;
                    }

                }

                Image {
                    id: clearSearch
                    source: "images/bt_browser_clear.png"
                    anchors.right: searchInput.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 20
                    visible: searchInput.focus && searchInput.text != '';
                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -15
                        onClicked: searchInput.text = '';
                    }
                }


            }
        }
    }
        BorderImage {
            id: shadow
            source: "images/shadow.png"
            anchors.top: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalTileMode: BorderImage.Repeat
            visible: (webView.contentY < 0);
        }
}
