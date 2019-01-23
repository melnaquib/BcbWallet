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
    readonly property bool isPortrait: mainWin.width < mainWin.height
    property int spacing: 5

    property real cvrt: .1 //bcb to usd

    property string wallet: settings.wallet
    property alias themeLight: settings.light

    Material.theme: themeLight ? Material.Light : Material.Dark
    Material.accent: themeLight ? "#0688c9" : "yellow"
    Material.background: themeLight ? "#e6e6e6" : "#212121"
    Material.foreground: Material.accent
    Material.primary: themeLight ? "#f9f9f9" : "#000000"

    property int currAccIdx: 1
//    property var accs: [{
//            "name": "Daily Account", "balance": "0", "unit": "",
//            "txs": []
//        }, {
//            "name": "Savings Account", "balance": "496", "unit": "M",
//            "txs": []
//        }]


    property var accs
    onWalletChanged: {
        accs = Rpc.walletAccounts(wallet);
        sidePanel.load(accs);
    }

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
        id: accHeader
        x: sidePanel.width
        width: parent.width - sidePanel.width

    }

    SidePanel {
        id: sidePanel
        isPortrait: mainWin.isPortrait
        width: mainWin.width * 0.3
        height: mainWin.height

        onAccountChanged: {
            accHeader.loadAcc(account);
            txsPage.loadAcc(account);
        }
    }

    StackView {
        id: stackView

         anchors.leftMargin: 5 + !isPortrait ? sidePanel.width : undefined

//        initialItem: "HomeForm.ui.qml"
        initialItem: sidePanel.settingsSelected ? settingsPage : txsPage

        Txs {
            id: txsPage
            padding: 10
//            account: sidePanel.account
            visible: !sidePanel.settingsSelected
        }

        SettingsPage {
            id: settingsPage
            wallet: "884F248258C9EB8843F88AA25A261DEC7F16491F7FCE5CCB69126112ED28253C"
            visible: sidePanel.settingsSelected

        }

        anchors.fill: parent
    }

    Settings {id: settings
        property alias wallet: settingsPage.wallet
        property alias light: settingsPage.light
    }

    background: Image {
        id: bg
        source: "images/bg.png"
    }
}
