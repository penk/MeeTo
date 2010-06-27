import Qt 4.7

Rectangle {
    id: toolbar
    height: 57
    color: "#222222"

    signal reloadClicked();
    signal stopClicked();
    signal backClicked();
    signal forwardClicked();
    signal optionsClicked();

    property bool loading : false
    property real progress : 0.0
    property string url : textInput.text

    onLoadingChanged: {
        if (loading)
            reload.source = ":images/bt_browser_stop.png";
        else
            reload.source = ":images/bt_browser_reload.png";
    }

    function setUrl(value) {
        textInput.text = value;
    }

    Image {
        id: back
        source: ":images/bt_browser_back.png"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: toolbar.backClicked();
        }
    }

    Image {
        id: forward
        source: ":images/bt_browser_forward.png"
        anchors.left: back.right
        anchors.verticalCenter: parent.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: toolbar.forwardClicked();
        }
    }

    BorderImage {
        id: input
        source: ":images/inputtext.png"
        anchors.left: forward.right
        anchors.right: reload.left
        anchors.verticalCenter: parent.verticalCenter

        border.left: 15;
        border.right: 15;

        BorderImage {
            source: ":images/inputtext_progress.png"
            /* XXX: use clip in the future when clip bug is fixed */
            width: Math.max(20, input.width * toolbar.progress)
            border.left: 10;
            border.right: 10;
            visible: (width > 20);
        }

        TextInput {
            id: textInput
            text: ""
            color: "black"
            anchors.fill: parent
            anchors.margins: 6
            font.family: "Nokia Sans"
            font.pixelSize: 22
            onAccepted: toolbar.reloadClicked();
        }
    }

    Image {
        id: reload
        source: ":images/bt_browser_reload.png"
        anchors.right: options.left
        anchors.verticalCenter: parent.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (toolbar.loading)
                    toolbar.stopClicked();
                else
                    toolbar.reloadClicked();
            }
        }
    }

    Image {
        id: options
        source: ":images/bt_browser_options.png"
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: toolbar.optionsClicked();
        }
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
