#include "uiproxy.h"

#include <QProcess>

UiProxy::UiProxy(QObject *parent) : QObject(parent)
{

}

QString UiProxy::nodeCmd(const QStringList &params) {
//    const QString node = "./btcb_node";
    const QString node = "../raiblocks_build/nano_node";
    QProcess p;
    p.start(node, params);
    p.waitForFinished();
    QByteArray ba = p.readAllStandardOutput();
    return QString(ba);
}
