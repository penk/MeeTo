//import QtQuick 1.0

import Qt 4.7
import QtMultimediaKit 1.1

Item {
    id: button
    signal clicked()
    property string type: "default"

    SoundEffect {
         id: playSound
         source: "qrc:/tock.wav"
    }

    Image {
        id: shadow
        source: (type == "default") ? ":image/pressed.png" : ":image/pressed-"+type+".png"
        z: 1.1
        opacity: 0
        anchors.left: parent.left
        anchors.top: parent.top
//        anchors.leftMargin: 1
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: { button.clicked(); playSound.play(); }
        onPressed: PropertyAnimation { target: shadow; properties: "opacity"; to: "0.8"; duration: 5 }
        onReleased: PropertyAnimation { target: shadow; properties: "opacity"; to: "0"; duration: 5 }
    }
}
