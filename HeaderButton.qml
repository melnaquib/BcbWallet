import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2


ToolButton {
    Layout.preferredHeight: parent.height
    Layout.preferredWidth: height
//    Layout.bottomMargin: 50
    id: control

    property bool light: Material.Light == Material.theme
    property color iconColor: light ? "black" : "white"
    icon.color: iconColor

    background: Rectangle {color: Material.primary; anchors.margins: 10}

    padding: 40

    Rectangle {
        anchors.fill: parent
        radius: parent.height / 2
//        color: "#00000000"
        border.width: 2
        border.color: "white"
//        anchors.margins: 20
        color: "black"

        scale: .6

    }

//    contentItem: Text {
//        text: control.text
//        font: control.font
//        opacity: enabled ? 1.0 : 0.3
//        color: control.down ? "#17a81a" : "#21be2b"
//        horizontalAlignment: Text.AlignHCenter
//        verticalAlignment: Text.AlignVCenter
//        elide: Text.ElideMiddle
//    }

//    contentItem: ColumnLayout {
//            //anchors.horizontalCenter: parent.horizontalCenter
//            spacing: 5
//            Label {
//                text: control.text
////                    font: control.font
//                Layout.alignment: Qt.AlignVCenter
//            }
//            Image {
//                source: control.icon.source
//                width: control.icon.width
//                height: control.icon.height
//                Layout.alignment: Qt.AlignVCenter
//            }
//        }

    Label {
        text: parent.text
//        text: "AZWSXqazwsx"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.horizontalCenter:  parent.horizontalCenter
//        color: Material.foreground
        color: "yellow"
    }

}
