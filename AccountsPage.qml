import QtQuick 2.9
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0


Page {
    id: accountsPage

    header: ToolBar {
        ToolButton {
            text: "Add"
            onClicked: {
                accsModel.append({name: "", model: ""});
            }
        }
        ToolButton {
            text: "Remove..."
            onClicked: {
                var idx = listView.currentIndex;
                if(idx < 0) return;
                accsModel.remove(idx);
            }
        }
    }

    ListView {
        id: listView
        model: ListModel {id: accsModel}

    }

    Component.onCompleted: {
        load();
    }

    Component.onDestroyed: {
        save();
    }

    function load() {
        var accs = JSON.parse(accountsStr);
        for(var i = 0; i < accs.length; ++i) {
            accsModel.append(accs[i]);
        }
    }

    function save() {
        var accs = [];
        for(var i = 0; i < accsModel.count; ++i) {
            var it = listView.itemAt(i);
            accs.append({name: it.name, account: it.account});
        }
        accStr = JSON.toString(accs);
    }

    property string accStr
    Settings {
        id: settings
        property alias accStr: accountsPage.accStr
    }

}
