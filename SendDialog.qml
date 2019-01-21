import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import "rpc.js" as Rpc

Dialog {

    ColumnLayout {
        anchors.fill: parent

        TextField {
            id: accountTf
            placeholderText: "Account"
        }
        TextField {
            id: amountTf
            placeholderText: "Amount"
        }

    }

    onAccepted: {
        Rpc.send(accountTf.text, amountTf.text);
    }

}
