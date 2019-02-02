#ifndef UIPROXY_H
#define UIPROXY_H

#include <QObject>

class UiProxy : public QObject
{
    Q_OBJECT
public:
    explicit UiProxy(QObject *parent = nullptr);

signals:

public slots:
    QString nodeCmd(const QStringList &params);
};

#endif // UIPROXY_H
