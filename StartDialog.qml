import QtQuick 2.9
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import "rpc.js" as Rpc


Dialog {

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
    }

//    Rectangle {
//        anchors.fill: parent
//        color: "yellow"
//    }


    GridLayout {
        anchors.fill: parent
        anchors.margins: 10

        columns: 1

        ComboBox {
            id: wallet
            model: Rpc.wallets(proxy)
            editable: false
//            textRole: "id"
            Layout.fillWidth: true
        }

        TextField {
            id: seed
            placeholderText: qsTr("Password")
        }

        Button {
            text: qsTr("Generate...")
//            onClicked: {newWalletDlg.open();}
            onClicked: {
                alert();
                Rpc.newWallet(password.text);
            }
        }

    }

    onAccepted: {
        Rpc.unlock()
    }

    onRejected: {
        Qt.quit();
    }

    Dialog {
        id: newWalletDlg
        height: parent.height
        width: parent.width

        onOpened: {
            var walletId = Rpc.newWallet(seed.text);
            reload();
        }

        onAccepted: {

        }


    }

    function reload() {
        wallet.model = 0;
        wallet.model = Rpc.wallets(proxy);
    }

}
