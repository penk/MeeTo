import QtQuick 1.0
import QtMobility.sensors 1.1

import QtWebKit 1.0
//import MeeTo 1.0
import "resource"

Rectangle {
    id: webBrowser

    property string urlString : "" //"http://www.google.com/"

    width: 1024; height: 600
    color: "black"

    OrientationSensor {
        id: orientation
        active: false // true

        onReadingChanged: {
            if (reading.orientation == OrientationReading.TopUp)
                frame.state = "TopUp"; 
            else if (reading.orientation == OrientationReading.TopDown)
                frame.state = "TopDown"; 
            else if (reading.orientation == OrientationReading.LeftUp)
                frame.state = "LeftUp"; 
            else if (reading.orientation == OrientationReading.RightUp)
                frame.state = "RightUp"; 
            else
                frame.state = "RightUp"; 
        }
    }

    Rectangle {
        id: frame;
        width: 1024; height: 600
        x: 0; y: 0

        Image {
            anchors.fill: parent;
            source: "resource/images/UIStockImageScrollViewTexturedBackgroundColor.png"
            fillMode: Image.Tile
        }

        states: [
            State {
                name: "TopUp"
                changes: [
                    PropertyChanges { target: frame; rotation: -90 },
                    PropertyChanges { target: frame; height: 1024; width: 600; x: 213; y: -212 }
                ]
            },
            State {
                name: "TopDown"
                changes: [
                    PropertyChanges { target: frame; rotation: 90; },
                    PropertyChanges { target: frame; height: 1024; width: 600; x: 213; y: -212 }
                ]
            },
            State {
                name: "LeftUp"
                changes: [
                    PropertyChanges { target: frame; rotation: 180 },
                    PropertyChanges { target: frame; height: 600; width: 1024; x: 0; y: 0 }
                ]
            },
            State {
                name: "RightUp"
                changes: [
                    PropertyChanges { target: frame; height: 600; width: 1024; x: 0; y: 0 }
                ]
            }
        ]

     transitions: Transition {
             RotationAnimation { duration: 300; direction: RotationAnimation.Clockwise }
     }


    FlickableWebView {
        id: webView
        url: webBrowser.urlString
        onProgressChanged: header.urlChanged = false
        anchors { top: headerSpace.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }
    }

/*
    TabView {
        id: tabView
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom


        onUrlChanged: toolbar.setUrl(tabView.url);

        Connections {
            target: mainWindow
            onResized: tabView.updateSnapshots(true);
        }

    }
*/

    Item { id: headerSpace; width: parent.width; height: 58 }


    Header {
        id: header
        editUrl: webBrowser.urlString
        width: headerSpace.width; height: headerSpace.height
        anchors.top: parent.top;
    }


    ScrollBar {
        scrollArea: webView; width: 11;
        anchors { right: parent.right; top: headerSpace.bottom; bottom: parent.bottom; rightMargin: 3; topMargin: 5; bottomMargin: 5 }
    }

    ScrollBar {
        scrollArea: webView; height: 11; orientation: Qt.Horizontal
        anchors { right: parent.right; rightMargin: 8; left: parent.left; bottom: parent.bottom }
    }


    }
}
