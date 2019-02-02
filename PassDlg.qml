import QtQuick 2.7
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0

import "rpc.js" as Rpc


Dialog {
    id: passDlg

    property string wallet

    property bool newSeed: wallet ? false : true
//    property bool newSeed: true

    standardButtons: Dialog.Ok | Dialog.Cancel

    onRejected: {
        Qt.quit();
    }

    onAccepted: {
        if(newSeed) {
            wallet = Rpc.newWallet();
            Rpc.setSeed(wallet, seed.text);
            Rpc.setPasswd(wallet, passwd.text);
            Rpc.unlockWallet(wallet, passwd.text);
        } else {
            var ok = Rpc.unlockWallet(wallet, passwd.text)
            if(!ok) {
                console.log("wrong passwd!");
                Qt.quit();
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        TextField {
            id: passwd
            placeholderText: qsTr("Password")
            echoMode: TextField.PasswordEchoOnEdit
            Layout.fillWidth: true
        }
        TextField {
            id: passwdConfirm
            placeholderText: qsTr("Confirm Password")
            echoMode: TextField.PasswordEchoOnEdit
            visible: passDlg.newSeed
            Layout.fillWidth: true
        }
        TextField {
            id: seed
            placeholderText: qsTr("Seed")
            echoMode: TextField.PasswordEchoOnEdit
            visible: passDlg.newSeed
            Layout.fillWidth: true
        }
    }

    Settings {id: settings
        property alias wallet: passDlg.wallet
//        property alias light: settingsPage.light
    }

    Component.onCompleted: {
        newSeed = wallet ? false : true;
    }

}
