import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtQuick.Controls.Material 2.2

import "fmt.js" as Fmt

//Item {
//    anchors.fill: parent

ToolBar {
    id: header
    //        height: btnRecv.implicitHeight
    height: Math.max(accountInfo.implicitHeight, btnRecv.implicitHeight)
//    height: Math.max(accountInfo.implicitHeight, btnRecv.height)
//    height: 120
//    anchors.leftMargin: 5 + !inPortrait ? drawer.width : undefined

    property string name: ""
    property string pending: ""
    property string balance: ""

    background: Item{}

RowLayout {
    anchors.fill: parent

    HeaderButton {
        id: btnRecv
        text: qsTr("Receive")
        icon.source: "images/icons/recv.png"
        Layout.alignment: Qt.AlignLeft
    }

    ColumnLayout {
        id: accountInfo
        Layout.alignment: Qt.AlignVCenter
//        anchors.centerIn: parent

        Label {
            text: name
            Layout.alignment: Qt.AlignHCenter
            color: Material.foreground
        }
        Label {
            text: Fmt.fmtAcc(account)
            Layout.alignment: Qt.AlignHCenter
        }
        Label {
            text: Fmt.fmt(balance)
            Layout.alignment: Qt.AlignHCenter
        }
//        Label {
//            text: "254.99$"
//            Layout.alignment: Qt.AlignHCenter
//        }
    }

    HeaderButton {
        text: qsTr("Send")
        icon.source: "images/icons/send.png"
        Layout.alignment: Qt.AlignRight
//        anchors.left: parent.left
    }

}

function loadAcc(accs, a) {
    var i = -1;
    for(i = 0; i < accs.length; ++i) {
        if(account == accs[i].account) break;
    }

    if(i >= 0 && i < accs.length) {
        var acc = accs[i];
        account = acc.account;
        name = acc.name;
        balance = acc.balance;
        pending = "";
    } else {
        account = "";
        balance = "";
        pending = "";
        name = "";
    }


}

}

//}
