/*
*/

import Qt 4.7

Item {
    id: homescreen
    anchors.topMargin: 20
/*
    anchors.top: parent.top;
    anchors.right: parent.right; 
    anchors.left: parent.left;
*/

    VisualItemModel {
        id: itemModel

        Item {
            width: view.width; height: view.height

            Row { 
                anchors { top: parent.top; left: parent.left; margins: 50 }
                spacing: 50

                Item {
                    width: 130; height: 130
                    Image { source: "content/WallpaperIconShadowT.png"; anchors.fill: parent; } 
                    Image { source: "content/Safari.png"; anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "<b>Safari</b>"; color: "white"; style: Text.Raised; styleColor: "black"; 
                            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 30 }
                    }

                    MouseArea { anchors.fill: parent; onClicked: launch("mbrowser"); } 
                }

                Item {
                    width: 130; height: 130
                    Image { source: "content/WallpaperIconShadowT.png"; anchors.fill: parent; } 
                    Image { source: "content/Preferences.png"; anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "<b>Settings</b>"; color: "white"; style: Text.Raised; styleColor: "black"; 
                            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 30 }
                    }

                    MouseArea { anchors.fill: parent; onClicked: launch("msetting"); }
                }

                Item {
                    width: 130; height: 130
                    Image { source: "content/WallpaperIconShadowT.png"; anchors.fill: parent; } 
                    Image { source: "content/Photos.png"; anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "<b>Photos</b>"; color: "white"; style: Text.Raised; styleColor: "black"; 
                            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 30 }
                    }
                }


                Item {
                    width: 130; height: 130
                    Image { source: "content/WallpaperIconShadowT.png"; anchors.fill: parent; } 
                    Image { source: "content/accessories-calculator.svg"; width: 74; height: 76; anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "<b>Calculator</b>"; color: "white"; style: Text.Raised; styleColor: "black"; 
                            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 30 }
                    }
                }

                Item {
                    width: 130; height: 130
                    Image { source: "content/WallpaperIconShadowT.png"; anchors.fill: parent; } 
                    Image { source: "content/qtdesigner.svg"; width: 74; height: 76; anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "<b>Qt Designer</b>"; color: "white"; style: Text.Raised; styleColor: "black"; 
                            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 30 }
                    }
                }

            }
        }

        Item {
            width: view.width; height: view.height

            Row { 
                anchors { top: parent.top; left: parent.left; margins: 50 }
                spacing: 50

                Item {
                    width: 130; height: 130
                    Image { source: "content/WallpaperIconShadowT.png"; anchors.fill: parent; } 
                    Image { source: "content/iBooks.png"; anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "<b>iBooks</b>"; color: "white"; style: Text.Raised; styleColor: "black"; 
                            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 30 }
                    }
                    MouseArea { anchors.fill: parent; onClicked: launch("mbooks"); } 
                }

            }
        }

     }

     ListView {

         id: view
         anchors { fill: parent; bottomMargin: 130 }
         model: itemModel
         preferredHighlightBegin: 0; preferredHighlightEnd: 0
         highlightRangeMode: ListView.StrictlyEnforceRange
         orientation: ListView.Horizontal
         snapMode: ListView.SnapOneItem; flickDeceleration: 5000
        boundsBehavior: Flickable.StopAtBounds
         cacheBuffer: 500
     }

    Image {
        anchors.top: parent.top;
        anchors.right: parent.right; 
        anchors.left: parent.left;
        fillMode: Image.TileHorizontally;
        source: "content/WallpaperGradientLandscape.png"
    }

     Item {
         width: parent.width; height: 30
         anchors { top: view.bottom; }

         Row {
             anchors.centerIn: parent
             spacing: 15

             Repeater {
                 model: itemModel.count

                 Rectangle {
                     width: 6; height: 6
                     radius: 3
                     color: "white"
                     opacity: view.currentIndex == index ? 1 : 0.3

                     MouseArea {
                         width: 20; height: 20
                         anchors.centerIn: parent
                         onClicked: view.currentIndex = index
                     }
                 }
             }
         }
     }

    Image {
        id: dock
        anchors { bottom: parent.bottom; } 
        source: "content/SBDockBGT-Landscape.png"

            Row {
                    anchors { bottom: parent.bottom; left: parent.left; right: parent.right; leftMargin: 130; }
                    spacing: 80

                Item {
                    width: 130; height: 110
                    Image { source: "content/utilities-terminal.svg"; width: 74; height: 76; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "<b>Terminal</b>"; color: "white"; style: Text.Raised; styleColor: "black"; 
                            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 15; }
                    }
                }

                Item {
                    width: 130; height: 110

                    Image { source: "content/emesene.svg"; width: 74; height: 76; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "<b>Emesene</b>"; color: "white"; style: Text.Raised; styleColor: "black"; 
                            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 15; }
                    }
                }

                Item {
                    width: 130; height: 110
                    //anchors { bottom: parent.bottom; left: parent.left; right: parent.right;  }
                    Image { source: "content/facebook.svg"; width: 74; height: 76; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "<b>Facebook</b>"; color: "white"; style: Text.Raised; styleColor: "black"; 
                            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 15; }
                    }
                }

                Item {
                    width: 130; height: 110
                    //anchors { bottom: parent.bottom; left: parent.left; right: parent.right;  }
                    Image { source: "content/addressbook.svg"; width: 74; height: 76; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "<b>Contacts</b>"; color: "white"; style: Text.Raised; styleColor: "black"; 
                            anchors { horizontalCenter: parent.horizontalCenter; bottom: parent.bottom; bottomMargin: 15; }
                    }
                }

            }

    }

}
