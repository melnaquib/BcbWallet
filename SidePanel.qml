import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3


Drawer {
    id: sidePanel

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
        anchors.margins: 10

        Image {
            id: logo
            source: "icons/logo.png"
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.preferredWidth: parent.width / 2
            Layout.preferredHeight: width
//            Rectangle {anchors.fill: parent;  radius: 20; color: "red"}
        }

        ListView {
            id: accsList
//            model: accs.length
            width: parent.width
            keyNavigationWraps: true
            interactive: true
            boundsBehavior: Flickable.StopAtBounds
            spacing: 5
            focus: true

//                height: 400
//                height: implicitHeight
//            Layout.fillHeight: true
            Layout.fillHeight: true

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
                width: parent.width
                anchors.margins: 5
                property string account: accs[index]["account"]
                onClicked: {
                    accsList.currentIndex = index;
                }
                clip: true

                    ColumnLayout {
    //                anchors.fill: parent
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                    width: parent.width
                    Label {
                        text: accs[index]["name"]
                        Layout.leftMargin: 5
                        Layout.rightMargin: 5
                    }
                    Label {
                        text: accs[index]["balance"]
                        Layout.leftMargin: 5
                        Layout.rightMargin: 5
                    }

                }
            }
        }

        Button {
            text: "+ Add new account"
            flat: true
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
        }
        Button {
            id: settingsBtn
            text: "Settings"
            icon.source: "icons/options.png"
            flat: true
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            checkable: true
        }
        Button {
            text: "Log out"
            icon.source: "icons/logout.png"
            Layout.alignment: Qt.AlignBottom
            flat: true
            Layout.fillWidth: true
            onClicked: Qt.quit()
        }

    }

    function load(accs) {
        sidePanel.accs = accs;
        accsList.model = 0;
        accsList.model = accs.length;
    }
}

