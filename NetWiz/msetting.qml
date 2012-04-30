import Qt 4.7
import Connman.Qt 0.1
//import Qt.labs.components 1.1
import com.nokia.meego 1.0


Item {
    width: 1024
    height: 600

    Rectangle { 
	color: "white"
	anchors.fill: parent

    NetworkListModel {
        id: networkListModel
    }

    ClockModel {
        id: clockModel
    }

    Flickable {
        width: parent.width
        height: parent.height
        contentHeight: content.height
        interactive: true


        Column {
            id: content
            width: parent.width

            Text { text: "WiFi Setting: \n"
            	font.weight: Font.Bold
            	font.pointSize: 24 }
            
/*
            Row {
                TextInput {
                    id: timezoneEntry
                    width: 200
                    height: 40
                    text: clockModel.timezone
                }
                Button {
                    id: setButton
                    width: 100
                    height: 40

                    text: "Set"
                    onClicked: {
                        clockModel.timezone = timezoneEntry.text
                    }
                }
            }
            Button {
                id: updatesButton
                property string mode: clockModel.timezoneUpdates
                width: 280
                height: 50
                //color: mode == "auto" ? "blue" : "red"
                text: "TimezoneUpdates: " + updatesButton.mode

                onClicked: {
                    if (updatesButton.mode == "auto")
                        clockModel.timezoneUpdates = "manual";
                    else
                        clockModel.timezoneUpdates = "auto";
                }
            }

            Button {
                id: button
                property bool airplane: networkListModel.offlineMode
                width: 150
                height: 50
                //color: button.airplane ? "red":"blue"

                text: "offline: " + button.airplane


                onClicked: {
                    networkListModel.offlineMode = !button.airplane
                }

            }
            

            Column {
                width: childrenRect.width
                Row {
                    height: 50
                    spacing: 10
                    Text { text: "Available technologies" }
                    Repeater {
                        model: networkListModel.availableTechnologies
                        delegate: Text {
                            text: modelData
                            height: 50
                        }
                    }
                }

                Row {
                    height: 50
                    spacing: 10
                    Text { text: "Enabled technologies" }
                    Repeater {
                        model: networkListModel.enabledTechnologies
                        delegate: Text {
                            text: modelData
                            height: 50
                        }
                    }
                }

                Row {
                    height: 50
                    spacing: 10
                    Text { text: "Connected technologies" }
                    Repeater {
                        model: networkListModel.connectedTechnologies
                        delegate: Text {
                            text: modelData
                            height: 50
                        }
                    }
                }
            }

*/

            Column {
                width: parent.width
                Repeater {
                    model: networkListModel
                    delegate: Rectangle {
                        width: parent.width
                        height: 55
                        radius: 10

                        function getStateString()
                        {
                            if(model.state === NetworkItemModel.StateIdle) {
                                return  "Idle"
                            }
                            else if(model.state === NetworkItemModel.StateFailure) {
                                return qsTr("Failed to Connect")
                            }
                            else if(model.state === NetworkItemModel.StateAssociation) {
                                return qsTr("Associating")

                            }
                            else if(model.state === NetworkItemModel.StateConfiguration) {
                                return qsTr("Configuring")

                            }
                            else if(model.state === NetworkItemModel.StateReady) {
                                return qsTr("Ready")

                            }
                            else if(model.state === NetworkItemModel.StateOnline) {
                                return qsTr("Connected")
                            }

                            return "Unknown"
                        }

                        Row {
                            height: 45
                            spacing: 10
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter

                            Text {
                            	font.pointSize: 18
                                text: name //+ " " + type
                                height: parent.height
                                verticalAlignment: Text.AlignVCenter
                            }


		     	    Item {
		     	    
		     	        width: 200
		     	        height: 50
		     	        
                                visible: model.security !== "none" && (model.state !== NetworkItemModel.StateOnline)
		     	        
		     	        BorderImage {
		     	        	source: "ineedit.sci"
		     	        	anchors.fill: parent
		     	        }
                            TextInput {
                                id: passwordTextInput
                                height: 40
                                width: 180
                                font.pointSize: 18 
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                anchors.top: parent.top
                                anchors.topMargin: 10
                                text: model.passphrase === "" ? "Password" : model.passphrase
                                visible: model.security !== "none" && (model.state !== NetworkItemModel.StateOnline)
                            }
				}

                            Column {
                                width: childrenRect.width

                                Text {
                                    text: "ip address: " + model.ipaddress
                                }

                                Text {
                                    text: "security: " + model.security
                                }

                                Text {
                                    text: "state: " + getStateString();
                                }
                            }
                        }

                        Button {
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            width: 200
                            height: 50
                            text: model.state === NetworkItemModel.StateOnline ? "Disconnect":"Connect"

                            onClicked: {
                                if(text == "Connect")
                                {
                                    if(model.type === "wifi") {
                                        model.networkitemmodel.passphrase = passwordTextInput.text;
                                        model.networkitemmodel.connectService();
                                        //networkListModel.connectService(model.ssid, model.security, passwordTextInput.text)
                                    }
                                    else {
                                        model.networkitemmodel.connectService();
                                    }
                                }
                                else {
                                    model.networkitemmodel.disconnectService();
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    }
}
