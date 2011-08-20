/*
*/

import QtQuick 1.0
import QtMultimediaKit 1.1

Rectangle {
    id: screen
    width: 1024; height: 600

    property bool locked: true

    property string shortDate
    property string shortTime

    function currentDateTime() {
        var date = new Date();
        shortDate = Qt.formatDateTime(date, "dddd, MMMM d")
        shortTime = Qt.formatDateTime(date, "h:mm")
    }

    Timer {
         interval: 6000; running: true; repeat: true;
         onTriggered: screen.currentDateTime()
    }

    SoundEffect {
         id: unlockSound
         source: "content/unlock.wav"
    }

    SoundEffect {
         id: lockSound
         source: "content/lock.wav"
    }

    function unlock() {
        console.log('screen unlocked');
        unlockSound.play();
        locked = false
        pageLoader.source = "homescreen.qml"
    }

    function launch(app) {
        console.log("Launch: " + app);
        pageLoader.source = app + "/main.qml";
    }

    function lock() {
        console.log('screen locked');
        lockSound.play();
        locked = true
        pageLoader.source = "lockscreen.qml"; 
    }

    function gohome() {
        if (!locked) {
            pageLoader.source = "homescreen.qml"
        }
    }

    Image { 
        anchors { fill: parent }
        source: "content/wallpaper_landscape.png"
    }

    Rectangle {
        id: statusbar

        height: 20
        width: parent.width
        anchors.top: parent.top
        color: "black"
        opacity: 0.7

        Image {
            anchors.centerIn: parent
            source: "content/FSO_LockIcon.png"
            visible: locked
        }


        Text {
            anchors.centerIn: parent
            visible: !locked
            color: "white"
            text: shortTime
        }

        Text {
            anchors.left: parent.left
            id: brand
            font.pointSize: 10
            anchors.leftMargin: 5
            anchors.rightMargin: 50
            color: "white"
            text: "<b>MeeTo</b>"
        }

        Image {
            anchors.left: brand.right
            anchors.leftMargin: 5
            source: "content/FSO_3_AirPort.png"
        }

        Image {
            anchors.right: parent.right
            anchors.rightMargin: 5
            source: "content/FSO_BatteryCharging.png"
        }

    }

    Loader { 
        id: pageLoader
        anchors.fill: parent
        focus: true
        source: "lockscreen.qml"
        onLoaded: screen.currentDateTime()
    }
}
