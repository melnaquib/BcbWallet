import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Universal 2.3
import QtQuick.Controls.Material 2.3

import "accs.js" as Accs
import "rpc.js" as Rpc
import "fmt.js" as Fmt

Page {

//    property alias style: Material
    id: txsPage
    background: Item{}

    property var txs
    property var acc

    header: RowLayout {
        height: tfTxSearch.implicitHeight
        width: parent.width

        spacing: 10

//        ComboBox {}
        TextField {
            id: tfTxSearch
            Layout.fillWidth: true
        }
        Button {
            icon.source: "images/icons/reload.png"
            onClicked: { reload();}
//            background: Item{}
            flat: true
        }

    }

    ListView {
        id: txsListView
        model: txs.length
        anchors.fill: parent
        anchors.margins: 10
        spacing: 5

        function getTxDescr(receive, bind) {
            return receive ? (bind ? "Receiving" : "Received") : (bind ? "Sending" : "Sent")
        }

        delegate: RowLayout {
            id: txRow
            property var tx: index < txs.length ? txs[index] : {type: "", binding: "", date: "", binding: ""}

            property bool receive: "receive" == tx.type

            Rectangle {
                width: height
                height: txSymbolTxt.height
                radius: height / 2
                color: receive ? "lightBlue" : "white"
                Text {
                    id: txSymbolTxt
                    anchors.centerIn: parent
                    text: receive ? "+" : "-"
                    font.bold: true
                    opacity:  tx.binding ? 0.5 : 1.0
                }
            }

            Label {
                text: tx.date
                color: Material.foreground
            }
            Label {
                text: txsListView.getTxDescr(receive, tx["binding"])
                color: "white"
            }
            Label {
                text: Fmt.fmt(tx["amount"])
                color: Material.foreground
            }
        }
    }

    function loadAcc(acc) {
        if(! acc) acc = "";
        txsPage.acc = acc;
        txs = Rpc.account_history(acc);
        txsListView.model = 0;
        txsListView.model = txs.length;

    }
    function reload() {
        loadAcc(acc);
    }

    Timer {
        interval: 60 * 1000
        repeat: true
        running: true
        onTriggered: {
            reload();
        }
    }

}
