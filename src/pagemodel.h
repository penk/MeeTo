#ifndef TABMODEL_H
#define TABMODEL_H

#include <QObject>
#include <QStringList>
#include <QStandardItemModel>

class PageModel : public QStandardItemModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ rowCount NOTIFY countChanged);

public:
    PageModel(QObject *parent = 0);

    Q_INVOKABLE void add(const QString &title, const QString &url);
    Q_INVOKABLE void remove(int index);

    Q_INVOKABLE void setUrl(int index, const QString &url);
    Q_INVOKABLE void setTitle(int index, const QString &title);
    Q_INVOKABLE void setSnapshot(int index, const QPixmap &pixmap);

signals:
    void countChanged();
};

#endif
