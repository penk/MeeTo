import QtQuick 1.0

Item {
    id: toggleswitch

    width: 300
    height: 96

    property bool on: false
    signal message(string msg)

    Image {
        id: background
        anchors.fill: parent
        source: "bottombar.png"

        AnimatedImage { id: animation; anchors.right: parent.right; anchors.rightMargin: 0; source: "slide-to-unlock.gif" }
    }

    Image {
        id: knob
        x: 20; y: 26
        source: "bottombarknobgrayT.png"

        MouseArea {
            anchors.fill: parent
            anchors.margins: -30
            drag.target: knob; drag.axis: Drag.XAxis; drag.minimumX: 20; drag.maximumX: 215
            onReleased: { if (knob.x < 215) { bounce.restart(); } else { toggleswitch.message("clicked!"); console.log('unlock'); } }
        }
    }

    NumberAnimation { id: bounce; target: knob; properties: "x"; to: 20; easing.type: Easing.InOutQuad; duration: 200 }
}
