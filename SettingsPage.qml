import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0


Page {

    property alias light: lightCb.checked
    property alias wallet: walletTf.text
    background: Item{}

    GridLayout {
        columns: 1

        CheckBox {
            id: lightCb
            text: qsTr( checked ? "Light" : "Dark")
            checked: true
        }
        TextField {
            id: walletTf
            placeholderText: qsTr("wallet")
        }
    }

}
