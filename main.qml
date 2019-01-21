import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import "rpc.js" as Rpc

ApplicationWindow {
    id: mainWin
    visible: true
    width: 800
    height: 600
//    title: qsTr("Stack")
    readonly property bool isPortrait: mainWin.width < mainWin.height

    property alias wallet: walletTf.text


    property int spacing: 5

//    property var style: Material

    property real cvrt: .1

    property int currAccIdx: 1
//    property var accs: [{
//            "name": "Daily Account", "balance": "0", "unit": "",
//            "txs": []
//        }, {
//            "name": "Savings Account", "balance": "496", "unit": "M",
//            "txs": []
//        }]


    property var accs: Rpc.walletAccounts(wallet);

    Material.theme: day.checked ? Material.Light : Material.Dark

    RowLayout {
        z:1
        anchors.top: parent.top
        anchors.left: parent.left
//        height: day.implicitHeight
        height: 20

        CheckBox {
            id: day
            text: qsTr(checked ? "Day" : "Night")
            z: 1
            checked: true

        }
        Button {
            text: qsTr("Wallet")
            onClicked: walletDlg.open();
        }
    }


    header: Header {
        x: sidePanel.width
        width: parent.width - sidePanel.width
    }

    SidePanel {
        id: sidePanel
        isPortrait: mainWin.isPortrait
        width: mainWin.width * 0.3
        height: mainWin.height

    }

    StackView {
        id: stackView

         anchors.leftMargin: 5 + !isPortrait ? sidePanel.width : undefined

//        initialItem: "HomeForm.ui.qml"
        initialItem: Txs {
            padding: 10
        }

        anchors.fill: parent
    }

    Dialog {
        id: walletDlg
        title: qsTr("Wallet")
        anchors.centerIn: parent

        standardButtons: Dialog.Ok

        contentItem: TextField {
            id: walletTf
            anchors.centerIn: parent
            placeholderText: "Wallet"
            text: "884F248258C9EB8843F88AA25A261DEC7F16491F7FCE5CCB69126112ED28253C"
        }
    }

    Settings {
        property alias wallet: mainWin.wallet
        property alias dayChecked: day.checked
    }
}
