import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import "fmt.js" as Fmt


Drawer {
    id: sidePanel

    background: Rectangle {color: "black"}

    property bool light: Material.Light == Material.theme
    property color iconColor: light ? "black" : "white"

    property string account: accsList.model ? accsList.currentItem.account : ""
    property var accs

    property bool isPortrait: false

    modal: isPortrait
    interactive: isPortrait
    position: isPortrait ? 0 : 1
    visible: !isPortrait

    property alias settingsSelected: settingsBtn.checked

    ColumnLayout {
        id: walletsLayout
        anchors.fill: parent
        anchors.margins: 20

        Image {
            id: logo
            source: "images/icons/logo.png"
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.preferredWidth: parent.width / 2
            Layout.preferredHeight: width
//            Rectangle {anchors.fill: parent;  radius: 20; color: "red"}
            scale: 0.7

            fillMode: Image.PreserveAspectFit
        }

        Label {
            text: "bitcoin black"
            color: "white"
            font.italic: true
            font.bold: true
            Layout.margins: 20
            Layout.alignment: Qt.AlignHCenter

            scale: parent.width / 1.4 / width

        }

        ListView {
            id: accsList
//            model: accs.length

            keyNavigationWraps: true
            interactive: true
            spacing: 5
            focus: true

//                height: 400
//                height: implicitHeight
//            Layout.fillHeight: true
            Layout.fillHeight: true
            Layout.fillWidth: true

            highlightFollowsCurrentItem: true
            highlightMoveDuration : 1000
            highlight: Rectangle {
//                width: 180; height: 40
                color: Material.primary
//                y: list.currentItem.y

                Rectangle {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    width: 2

//                    color: Material.Yellow
                    color: "yellow"
                }
            }


            delegate:
                MouseArea {
//                    z:1
//                    anchors.fill: parent
                height: childrenRect.height
                width: parent.width + 20
                anchors.margins: 5
                anchors.rightMargin: -20
                property string account: accs[index]["account"]
                onClicked: {
                    accsList.currentIndex = index;
                }
                clip: true

                    ColumnLayout {
    //                anchors.fill: parent
                    anchors.leftMargin: 5
                    anchors.rightMargin: 0
                    width: parent.width
                    Label {
                        text: accs[index]["name"]
                        Layout.leftMargin: 5
                        Layout.rightMargin: 0
                    }
                    Label {
                        text: Fmt.fmt(accs[index]["balance"])
                        Layout.leftMargin: 5
                        Layout.rightMargin: 0
                        color: iconColor
                    }

                }
            }
            onCurrentIndexChanged: {
                account = accsList.model ? accsList.currentItem.account : "";
            }
        }

//        Button {
//            text: "+ Add new account"
//            flat: true
//            Layout.alignment: Qt.AlignTop
//            Layout.fillWidth: true
//            icon.color: iconColor
//        }
        Button {
            id: settingsBtn
            text: "Settings"
            icon.source: "images/icons/settings.png"
            flat: true
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            checkable: true
            icon.color: iconColor
        }
        Button {
            text: "Log out"
            icon.source: "images/icons/logout.png"
            Layout.alignment: Qt.AlignBottom
            flat: true
            Layout.fillWidth: true
            onClicked: Qt.quit()
            icon.color: iconColor
        }

    }

    Timer {
        repeat: true
        interval: 60 * 1000
        onTriggered: {
            load(accs);
        }
    }

    function load(accs) {
        sidePanel.accs = accs;
        accsList.model = 0;
        accsList.model = accs.length;
    }
}

