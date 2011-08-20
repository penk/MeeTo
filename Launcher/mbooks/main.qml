/*
*/

import QtQuick 1.0
import "mbooksCore"

Rectangle {
    id: mainWindow
    width: 1024
    height: 600

    Image {
        anchors.fill: parent
        source: "ibooks-bg.png"
    }
/*
    Image {
        anchors.fill: parent
        fillMode: Image.Tile
        source: "woodtile.png"
    }

    Item {
        id: navbar
        height: 44
        width: parent.width
        anchors.top: parent.top

        Image { id: navbarbg; source: "navbar.png" }
        Image { 
            anchors { top: navbarbg.bottom; left: parent.left; right: parent.right } 
            fillMode: Image.TileHorizontally; 
            source: "navbar-shadow.png" 
        }

        Image {
            source: "store.png"
            anchors { right: parent.right; margins: 8; top: parent.top } 
            Text { text: "<b>Store</b>"; color: "white"; style: Text.Sunken; styleColor: "black"; anchors.centerIn: parent }
        }

        Text {
            font.pointSize: 14
            anchors.centerIn: parent
            text: "<b>Books</b>"
            color: "#5E2900"
        }
    }

    Image {
        id: leftshading
        anchors { left: parent.left; top: navbar.bottom; bottom: parent.bottom }
        source: "side-shading.png"
        fillMode: Image.TileVertically
    }

    Image { 
        anchors { top: navbar.bottom; left: leftshading.right; right: rightshading.left; bottom: parent.bottom } 
        source: "nshading.png"
        fillMode: Image.Tile
    }

    Image {
        id: rightshading
        anchors { right: parent.right; top: navbar.bottom; bottom: parent.bottom }
        source: "right-side-shading.png"
        fillMode: Image.TileVertically
    }

    Image {
        y: 225
        source: "shelf.png"
    }

    Image {
        y: 415
        source: "shelf.png"
    }
*/



    ListModel {
        id: photosModel
        ListElement { tag: "gintama" }
        ListElement { tag: "usagidrop" }
        ListElement { tag: "onepiece" }
    }

    VisualDataModel { id: albumVisualModel; model: photosModel; delegate: AlbumDelegate {} }

    GridView {
        id: albumView; width: parent.width; height: 540; cellWidth: 210; cellHeight: 220
        model: albumVisualModel.parts.album; visible: albumsShade.opacity != 1.0
        anchors.bottom: parent.bottom
    }

    Rectangle {
        id: albumsShade; color: mainWindow.color
        width: parent.width; height: parent.height; opacity: 0.0
    }

    ListView { anchors.fill: parent; model: albumVisualModel.parts.browser; interactive: false }

    Button { id: backButton; label: qsTr("Back"); rotation: 3; x: parent.width - backButton.width - 6; y: -backButton.height - 8 }

    Rectangle { id: photosShade; color: 'black'; width: parent.width; height: parent.height; opacity: 0; visible: opacity != 0.0 }

    ListView { anchors.fill: parent; model: albumVisualModel.parts.fullscreen; interactive: false }

    Item { id: foreground; anchors.fill: parent }

}
