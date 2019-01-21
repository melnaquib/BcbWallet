import QtQuick 2.7
import QtQuick.Controls 2.9
import QtQuick.Controls.Material 2.3

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600
    title: qsTr("Stack")
    Material.theme: day ? Material.Light : Material.Dark

    CheckBox {
        id: day
        text: qsTr(checked ? "Day" : "Night")
        z: 1
        checked: true

    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.3
        height: window.height

//        Component.onCompleted: { open(); }

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1")
                width: parent.width
                onClicked: {
                    stackView.push("Page1Form.ui.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2")
                width: parent.width
                onClicked: {
                    stackView.push("Page2Form.ui.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "Txs.qml"
        anchors.fill: parent
    }

    Dialog {
        id: walletDlg
        title: qsTr("Wallet")
        anchors.centerIn: parent

        standardButtons: StandardButton.Save | StandardButton.Cancel

        contentItem: TextField {
            id: walletTf
            anchors.centerIn: parent
        }
    }

}
