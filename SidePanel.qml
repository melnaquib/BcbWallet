import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3


Drawer {
    id: drawer

//    property string account: accsList.currentItem.pubk
    property string account: ""

    property bool isPortrait: false

    modal: isPortrait
    interactive: isPortrait
    position: isPortrait ? 0 : 1
    visible: !isPortrait


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
            model: accs.length
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
                onClicked: {
                    accsList.currentIndex = index;
                }
                clip: true

                    ColumnLayout {
    //                anchors.fill: parent
                    property string pubk: accs[index]["name"]
    //                property alias pubk: accs[index]["name"]
                    width: parent.width
                    Label {
                        text: accs[index]["name"]
                    }
                    Label {
                        text: accs[index]["balance"]
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
            text: "Settings"
            icon.source: "icons/options.png"
            flat: true
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
        }
        Button {
            text: "Log out"
            icon.source: "icons/logout.png"
            Layout.alignment: Qt.AlignBottom
            flat: true
            Layout.fillWidth: true
        }

    }
}

