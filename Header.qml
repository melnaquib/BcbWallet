import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0


//Item {
//    anchors.fill: parent

ToolBar {
    //        height: btnRecv.implicitHeight
    height: accountInfo.implicitHeight
//    anchors.leftMargin: 5 + !inPortrait ? drawer.width : undefined

RowLayout {
    anchors.fill: parent

    HeaderButton {
        id: btnRecv
//        text: qsTr("Receive")
        icon.source: "icons/receive.png"
        Layout.alignment: Qt.AlignLeft
    }

    ColumnLayout {
        id: accountInfo
        Layout.alignment: Qt.AlignVCenter
//        anchors.centerIn: parent

        Label {
            text: accs[currAccIdx]["name"]
            Layout.alignment: Qt.AlignHCenter
        }
        Label {
            text: accs[currAccIdx]["balance"] + " " + accs[currAccIdx]["uint"] + "i"
            Layout.alignment: Qt.AlignHCenter
        }
        Label {
            text: "254.99$"
            Layout.alignment: Qt.AlignHCenter
        }
    }

    HeaderButton {
//        text: qsTr("Send")
        icon.source: "icons/send.png"
        Layout.alignment: Qt.AlignRight
//        anchors.left: parent.left
    }

}

}

//}
