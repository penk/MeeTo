import Qt 4.7

Rectangle {
    id: mainbar
    height: 38
    color: "#222222"

    property string title : ""

    BorderImage {
        source: ":images/divisor.png"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalTileMode: BorderImage.Repeat
    }

    Image {
        id: "close"
        anchors.right: parent.right
        anchors.rightMargin: 12
        source: ":images/bt_taskbar_close.png"

        MouseArea {
            anchors.fill: parent
            onClicked: mainWindow.close();
        }
    }

    Image {
        id: "home"
        anchors.left: parent.left
        anchors.leftMargin: 12
        source: ":images/bt_taskbar_home.png"
    }

    Text {
        text: mainbar.title
        font.family: "Nokia Sans"
        font.pixelSize: 22
        color: "#ffffff"
        style: Text.Sunken
        styleColor: "#000000"
        anchors.left: home.right
        anchors.right: close.left
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
    }

    BorderImage {
        id: shadow
        source: ":images/shadow.png"
        anchors.top: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        horizontalTileMode: BorderImage.Repeat
    }
}
