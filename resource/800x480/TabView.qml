import Qt 4.7

Item {
    id: tabView

    signal updateSnapshots(bool force);

    property int maxTabCount : 6
    property int spareHeight : 60
    property real finalScale : 0.6

    property string url : listview.currentItem.url
    property variant current : listview.currentItem

    Component {
        id: tabViewDelegate

        TabViewItem {
            id: tabItem
            deletable: (tabModel.count > 1)
            width: tabView.width * finalScale
            height: (tabView.height + tabView.spareHeight) * finalScale

            onRemoveClicked: tabModel.remove(index);

            ListView.onRemove: SequentialAnimation {
                PropertyAction { target: tabItem; property: "ListView.delayRemove"; value: true; }
                PropertyAction { target: blocker; property: "visible"; value: true; }
                ScriptAction {
                    script: {
                        ListView.view.snapMode = ListView.NoSnap;
                        ListView.view.highlightRangeMode = ListView.NoHighlightRange;
                    }
                }
                NumberAnimation { target: tabItem; property: "opacity"; to: 0.0; duration: 300; }
                NumberAnimation { target: tabItem; property: "width"; to: 0; duration: 300; }
                ScriptAction {
                    script: {
                        ListView.view.snapMode = ListView.SnapOneItem;
                        ListView.view.highlightRangeMode = ListView.StrictlyEnforceRange;
                    }
                }
                PropertyAction { target: blocker; property: "visible"; value: false; }
                PropertyAction { target: tabItem; property: "ListView.delayRemove"; value: false; }
            }
        }
    }

    ListView {
        id: listview
        spacing: 30
        anchors.fill: parent
        anchors.topMargin: 12
        anchors.leftMargin: parent.width * 0.2
        orientation: "Horizontal"
        cacheBuffer: 99999 /* keep tabs alive */
        model: tabModel
        delegate: tabViewDelegate

        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
    }

    MouseArea {
        id: blocker
        visible: false
        anchors.fill: parent
    }

    Item {
        id: tabOverlay
        anchors.fill: parent
    }

    Connections {
        target: listview.currentItem
        onClicked: tabView.state = "maximized";
        onNewTabRequest: if (tabModel.count < maxTabCount) tabModel.add("", "");
    }

    Component.onCompleted: tabView.state = "maximized";

    states: [
        State { name: "minimized"; extend: ""; },
        State {
            name: "maximized"
            PropertyChanges { target: blocker; visible: true; }
            PropertyChanges { target: listview; visible: false; }
            PropertyChanges { target: toolbar; visible: true; opacity: 1.0; }
            PropertyChanges { target: current.webview; visible: true; frozen: false; }
            PropertyChanges { target: current.websnap; visible: false; }
            ParentChange { target: current.webview; parent: tabOverlay; x: 0; y: 0; }
            ParentChange { target: current.websnap; parent: tabOverlay; x: 0; y: 0;
                           width: tabOverlay.width; height: tabOverlay.height + tabView.spareHeight; }
        }
    ]

    transitions: [
        Transition {
            from: "minimized"; to: "maximized";
            SequentialAnimation {
                PropertyAction { target: blocker; properties: "visible"; }
                ParentAnimation { target: current.webview; }
                PropertyAction { target: toolbar; properties: "visible"; }
                NumberAnimation { target: toolbar; properties: "opacity"; duration: 300; }
                ParentAnimation {
                    target: current.websnap; via: tabOverlay;
                    NumberAnimation { properties: "x,y,width,height"; easing.type: "OutExpo"; duration: 500; }
                }
                PropertyAction { target: listview; properties: "visible"; }
                PropertyAction { target: current.webview; properties: "visible,frozen"; }
                PropertyAction { target: current.websnap; properties: "visible"; }
                ScriptAction { script: current.reopen(); }
            }
        },
        Transition {
            from: "maximized"; to: "minimized";
            SequentialAnimation {
                ScriptAction { script: tabView.updateSnapshots(false); }
                PropertyAction { target: current.websnap; properties: "visible"; }
                PropertyAction { target: current.webview; properties: "visible,frozen"; }
                PropertyAction { target: listview; properties: "visible"; }
                ParentAnimation {
                    target: current.websnap; via: tabOverlay;
                    NumberAnimation { properties: "x,y,width,height"; easing.type: "OutExpo"; duration: 500; }
                }
                NumberAnimation { target: toolbar; properties: "opacity"; duration: 300; }
                PropertyAction { target: toolbar; properties: "visible"; }
                ParentAnimation { target: current.webview; }
                PropertyAction { target: blocker; properties: "visible"; }
            }
        }
    ]
}
