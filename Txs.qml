import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Universal 2.3
import QtQuick.Controls.Material 2.3

import "accs.js" as Accs
import "rpc.js" as Rpc

Page {

//    property alias style: Material
    background: Item{}

    property var txs

    header: RowLayout {
        height: tfTxSearch.implicitHeight
        width: parent.width

        ComboBox {}
        TextField {
            id: tfTxSearch
            Layout.fillWidth: true
        }
    }

    ListView {
        id: txsListView
        model: txs.length
        anchors.fill: parent
        spacing: 5

        function getTxDescr(receive, bind) {
            return receive ? (bind ? "Receiving" : "Received") : (bind ? "Sending" : "Sent")
        }

        delegate: RowLayout {
            id: txRow
            property var tx: txs[index]
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
                text: tx["amount"]
                color: Material.foreground
            }
        }
    }

    function loadAcc(acc) {
        if(! acc) acc = "";
        txs = Rpc.account_history(acc);
        txsListView.model = 0;
        txsListView.model = txs.length;

    }

}
