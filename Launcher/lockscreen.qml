/*
*/

import Qt 4.7
import "content"

Item {
    id: lockscreen

    Image {
        anchors.topMargin: 20
        anchors.top: parent.top;
        anchors.right: parent.right; 
        anchors.left: parent.left;
        fillMode: Image.TileHorizontally;
        source: "content/topbarbkg.png"

        Column {
            anchors.centerIn: parent
            height: parent.height  
            Text {
                font.pointSize: 48
                color: "white"
                text: shortTime
            }

            Text {
                font.pointSize: 12
                color: "white"
                text: "  " + shortDate
            }
        }
    }

    Image {
        anchors.bottom: parent.bottom;
        anchors.right: slider.left; 
        anchors.left: parent.left;
        fillMode: Image.TileHorizontally;
        source: "content/bottombarbkg.png"
    }

    Switch { id: slider; 
        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter; on: false
        onMessage: {unlock(); console.log('msg: ' + msg)}
    }

    Image {
        anchors.bottom: parent.bottom;
        anchors.left: slider.right; 
        anchors.right: parent.right;
        fillMode: Image.TileHorizontally;
        source: "content/bottombarbkg.png"
    }
}
