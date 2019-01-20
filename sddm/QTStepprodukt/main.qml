/***************************************************************************
* Copyright (c) 2015 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
* Copyright (c) 2013 Abdurrahman AVCI <abdurrahmanavci@gmail.com
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without restriction,
* including without limitation the rights to use, copy, modify, merge,
* publish, distribute, sublicense, and/or sell copies of the Software,
* and to permit persons to whom the Software is furnished to do so,
* subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included
* in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
* OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
* ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
* OR OTHER DEALINGS IN THE SOFTWARE.
*
***************************************************************************/

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls 1.4 as QQC
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import SddmComponents 2.0

Rectangle {
    id: container
    width: 1024
    height: 768
    
    color: "#555577"
	
// 	Use this to control all font sizes (also affects icons and overall size of the greeter)
	property double scalingFactor: 1

    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    property int sessionIndex: session.index

    TextConstants { id: textConstants }

    Connections {
        target: sddm
        onLoginSucceeded: {
        }

        onLoginFailed: {
			message.text = textConstants.loginFailed;
			passwd_entry.text = "";
        }
    }

    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                listView.focus = true;
            }
        }
    }

    Rectangle {
		anchors.fill: parent
		color: "transparent"
		//visible: primaryScreen
		
		Rectangle {
			id: "greeter"
// 			%2 ensures even numbers - odd numbers here causes rendering ugliness in children
			height: footer.height * 3 + 120 - (footer.height * 3 + 120) % 2
			width: height * 16/9 - (height * 16/9) % 2
			anchors.centerIn: parent
			
			BorderImage {
				anchors.fill: parent
				border.left: 3
				border.right: 4
				border.top: 3
				border.bottom: 4
				smooth: false
				source: "greeter.svg"
			}
			
			ColumnLayout {
				anchors.fill: parent
				anchors.leftMargin: 3
				anchors.rightMargin: 4
				anchors.topMargin: 3
				anchors.bottomMargin: 4
				spacing: 0
				Rectangle {
					id: header
					color: "transparent"
					Layout.margins: 16
					Layout.alignment: Qt.AlignTop
					Layout.fillWidth: true
					Layout.preferredHeight: footer.height
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.leftMargin: 2
						anchors.topMargin: 2
						color: "#000000"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.leftMargin: 2
						color: "#000000"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.topMargin: 2
						color: "#000000"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.leftMargin: -2
						anchors.topMargin: -2
						color: "#717576"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.leftMargin: -2
						color: "#717576"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.topMargin: -2
						color: "#717576"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.leftMargin: -1
						anchors.topMargin: -1
						color: "#717576"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.leftMargin: -1
						color: "#717576"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.topMargin: -1
						color: "#717576"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.leftMargin: 1
						anchors.topMargin: 1
						color: "#000000"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.leftMargin: 1
						color: "#000000"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						anchors.topMargin: 1
						color: "#000000"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.left: welcome_text.left
						anchors.top: welcome_text.top
						color: "#1c2021"
						text: welcome_text.text
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
					Text {
						anchors.centerIn: parent
						id: welcome_text
						color: "#becfd2"
						opacity: 0.25
						text: sddm.hostName
						font.bold: true
						font.family: "Liberation Sans"
						font.pixelSize: 57 * container.scalingFactor
					}
				}
				
				Image {
					height: 2
					Layout.fillWidth: true
					source: "separator.svg"
				}
				
				GridLayout {
					Layout.leftMargin: 16
					Layout.rightMargin: 16
					Layout.topMargin: 8
					Layout.bottomMargin: 8
					columns: 2
					
					Label {
						Layout.alignment: Qt.AlignRight
						text: textConstants.userName
						font.family: "Liberation Sans"
						font.pixelSize: 19 * container.scalingFactor
						color: "#becfd2"
					}
					
					TextField {
						id: user_entry
						text: userModel.lastUser
						Layout.fillWidth: true
						Layout.preferredHeight: font.pixelSize + 10
						font.family: "Liberation Sans"
						font.pixelSize: 19 * container.scalingFactor
						textColor: "#becfd2"
						style: TextFieldStyle {
							background: BorderImage {
								border.left: 2
								border.right: 1
								border.top: 2
								border.bottom: 1
								smooth: false
								source: control.focus ? "entry-focused.svg"
								                      : "entry.svg"
							}
						}
					}
					
					Label {
						Layout.alignment: Qt.AlignRight
						text: textConstants.password
						font.family: "Liberation Sans"
						font.pixelSize: 19 * container.scalingFactor
						color: "#becfd2"
					}
					
					TextField {
						id: passwd_entry
						echoMode: TextInput.Password
						Layout.fillWidth: true
						Layout.preferredHeight: font.pixelSize + 10
						font.family: "Liberation Sans"
						font.pixelSize: 19 * container.scalingFactor
						textColor: "#becfd2"
						style: TextFieldStyle {
							background: BorderImage {
								border.left: 2
								border.right: 1
								border.top: 2
								border.bottom: 1
								smooth: false
								source: control.focus ? "entry-focused.svg"
								                      : "entry.svg"
							}
						}
						Keys.onPressed: {
							if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
								sddm.login(user_entry.text, passwd_entry.text, sessionbutton.currentIndex);
								event.accepted = true;
							}
						}
					}
				}
				
				Image {
					height: 2
					Layout.fillWidth: true
					source: "separator.svg"
				}
				
				RowLayout {
					id: footer
					Layout.alignment: Qt.AlignBottom
					Layout.fillWidth: true
					Layout.margins: 16
					
// 					ComboBox {
// 						model: sessionModel
// 						index: sessionModel.lastIndex
// 					}
					
					ToolButton {
						Layout.alignment: Qt.AlignBottom
						id: sessionbutton
						property int currentIndex: -1
						
						style: ButtonStyle {
							padding.right: 7
							label: RowLayout {
								Label {
									Layout.fillWidth: true
									text: instantiator.objectAt(sessionbutton.currentIndex).text || ""
									font.family: "Liberation Sans"
									font.pixelSize: 19 * container.scalingFactor
									color: "#becfd2"
								}
								Image {
									source: "combo-indicator.svg"
								}
							}
							background: BorderImage {
								border.left: 1
								border.right: 2
								border.top: 1
								border.bottom: 2
								smooth: false
								source: control.pressed ? "button-pressed.svg"
								      : control.hovered ? "button-hover.svg"
								      : control.focus ? "button-hover.svg"
								      : "button.svg"
							}
						}
						
						Component.onCompleted: {
							currentIndex = sessionModel.lastIndex
						}
						
						menu: QQC.Menu {
							id: sessionmenu
							Instantiator {
								id: instantiator
								model: sessionModel
								onObjectAdded: sessionmenu.insertItem(index, object)
								onObjectRemoved: sessionmenu.removeItem(object)
								delegate: QQC.MenuItem {
									text: model.name
									onTriggered: {
										sessionbutton.currentIndex = model.index
									}
								}
							}
						}
					}
					
					Rectangle {
						Layout.fillWidth: true
						color: "transparent"
						Text {
							anchors.centerIn: parent
							id: message
							text: ""
							font.family: "Liberation Sans"
							font.pixelSize: 19 * container.scalingFactor
							color: "#810000"
						}
					}
					
					ToolButton {
						id: suspend_button
						visible: sddm.canSuspend
						Layout.preferredWidth: suspend_button_content.width + 7
						Layout.minimumWidth: suspend_button_content.height + 13
						Layout.preferredHeight: suspend_button_content.height + 13
						style: ButtonStyle {
							background: BorderImage {
								border.left: 1
								border.right: 2
								border.top: 1
								border.bottom: 2
								smooth: false
								source: control.pressed ? "button-pressed.svg"
								      : control.hovered ? "button-hover.svg"
								      : control.focus ? "button-hover.svg"
								      : "button.svg"
							}
						}
						ColumnLayout {
							id: suspend_button_content
							anchors.centerIn: parent
							spacing: 4
							Image {
								Layout.alignment: Qt.AlignCenter
								sourceSize.width: 32 * container.scalingFactor
								sourceSize.height: 32 * container.scalingFactor
								source: "suspend.svg"
							}
							Label {
								Layout.alignment: Qt.AlignCenter
								text: textConstants.suspend
								font.family: "Liberation Sans"
								font.pixelSize: 13 * container.scalingFactor
								color: "#becfd2"
								opacity: suspend_button.enabled ? 1 : 0.5
							}
						}
						onClicked: sddm.suspend()
					}
					
					ToolButton {
						id: reboot_button
						enabled: sddm.canReboot
						Layout.preferredWidth: reboot_button_content.width + 7
						Layout.minimumWidth: reboot_button_content.height + 13
						Layout.preferredHeight: reboot_button_content.height + 13
						style: ButtonStyle {
							background: BorderImage {
								border.left: 1
								border.right: 2
								border.top: 1
								border.bottom: 2
								smooth: false
								source: control.pressed ? "button-pressed.svg"
								      : control.hovered ? "button-hover.svg"
								      : control.focus ? "button-hover.svg"
								      : "button.svg"
							}
						}
						ColumnLayout {
							id: reboot_button_content
							anchors.centerIn: parent
							spacing: 4
							Image {
								Layout.alignment: Qt.AlignCenter
								sourceSize.width: 32 * container.scalingFactor
								sourceSize.height: 32 * container.scalingFactor
								source: "reboot.svg"
							}
							Label {
								Layout.alignment: Qt.AlignCenter
								text: textConstants.reboot
								font.family: "Liberation Sans"
								font.pixelSize: 13 * container.scalingFactor
								color: "#becfd2"
								opacity: reboot_button.enabled ? 1 : 0.5
							}
						}
						onClicked: sddm.reboot()
					}
					
					ToolButton {
						id: shutdown_button
						enabled: sddm.canPowerOff
						Layout.preferredWidth: shutdown_button_content.width + 7
						Layout.minimumWidth: shutdown_button_content.height + 13
						Layout.preferredHeight: shutdown_button_content.height + 13
						style: ButtonStyle {
							background: BorderImage {
								border.left: 1
								border.right: 2
								border.top: 1
								border.bottom: 2
								smooth: false
								source: control.pressed ? "button-pressed.svg"
								      : control.hovered ? "button-hover.svg"
								      : control.focus ? "button-hover.svg"
								      : "button.svg"
							}
						}
						ColumnLayout {
							id: shutdown_button_content
							anchors.centerIn: parent
							spacing: 4
							Image {
								Layout.alignment: Qt.AlignCenter
								sourceSize.width: 32 * container.scalingFactor
								sourceSize.height: 32 * container.scalingFactor
								source: "shutdown.svg"
							}
							Label {
								Layout.alignment: Qt.AlignCenter
								text: textConstants.shutdown
								font.family: "Liberation Sans"
								font.pixelSize: 13 * container.scalingFactor
								color: "#becfd2"
								opacity: shutdown_button.enabled ? 1 : 0.5
							}
						}
						onClicked: sddm.powerOff()
					}
				}
			}
		}
    }
    
    Component.onCompleted: {
		if (user_entry.text === "")
			user_entry.focus = true;
		else
			passwd_entry.focus = true;
	}
}
