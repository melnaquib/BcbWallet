import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0

import "rpc.js" as Rpc

ApplicationWindow {
    id: mainWin
    visible: true
    width: 800
    height: 600

    property int ds: 20

    readonly property bool isPortrait: mainWin.width < mainWin.height
    property int spacing: 5

    property real cvrt: .1 //bcb to usd

//    property string wallet
    property string wallet: passDlg.wallet

//    property alias themeLight: settings.light
    property bool themeLight: false

    Material.theme: themeLight ? Material.Light : Material.Dark
    Material.accent: themeLight ? "#0688c9" : "yellow"
    Material.background: themeLight ? "#e6e6e6" : "#212121"
    Material.foreground: themeLight ? "black" : "yellow"
    Material.primary: themeLight ? "#f9f9f9" : "#2f2f2f"

    background: Item {
        Image {
            id: bg
            source: themeLight ? "": "images/bg.png"
            anchors.fill: parent

        }

        BrightnessContrast {
            anchors.fill: bg
            source: bg
            brightness: -0.8
//            contrast: 0.9
        }

//        GammaAdjust {
//               anchors.fill: bg
//               source: bg
//               gamma: 0.0
//        }



    }


    property alias account: sidePanel.account

    property var accs
    onWalletChanged: {
        accs = Rpc.walletAccounts(wallet);
        sidePanel.load(accs);
    }


    SidePanel {
        id: sidePanel
        isPortrait: mainWin.isPortrait
        width: mainWin.width * 0.3
        height: mainWin.height

        onAccountChanged: {
            accHeader.loadAcc(accs, account);
            txsPage.loadAcc(account);
        }
    }

    header: BorderRect {
        id: headerBox
        x: sidePanel.width
        width: parent.width - sidePanel.width
        height: childrenRect.height + 20
        Header {
            id: accHeader
            x: ds
            width: parent.width - 2 * x
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    BorderRect {
//        anchors.left: sidePanel.right
        x: sidePanel.width + ds
        anchors.leftMargin: 5 + !isPortrait ? sidePanel.width : undefined
        anchors.topMargin: 0-ds
        anchors.fill: parent

        StackView {
            id: stackView
            anchors.fill: parent

//            width: parent.width - sidePanel.width
//            height: childrenRect.height
//            anchors.leftMargin: 5 + !isPortrait ? sidePanel.width : undefined
            anchors.margins: 20

    //        initialItem: "HomeForm.ui.qml"
            initialItem: sidePanel.settingsSelected ? settingsPage : txsPage

            Txs {
                id: txsPage
                padding: ds
    //            account: sidePanel.account
                visible: !sidePanel.settingsSelected
            }

            SettingsPage {
                id: settingsPage
                wallet: "884F248258C9EB8843F88AA25A261DEC7F16491F7FCE5CCB69126112ED28253C"
                visible: sidePanel.settingsSelected

            }
        }
    }

//    StartDialog {
//        id: startDlg

//        height: parent.height
//        width: parent.width

//        Component.onCompleted: {
//            startDlg.open();
//        }
//    }

    Component.onCompleted: {
        passDlg.open();
    }

    function setup() {
        if (! wallet) {
            newWallet();
        }
    }

    function newWallet() {
        Rpc.newWallet;
    }

    PassDlg {
        id: passDlg
        width: parent.width
        height: parent.height

//        property bool newSeed: !wallet
        newSeed: true
    }


}
