#include "pagemodel.h"

#define URL_ROLE Qt::UserRole + 1
#define TITLE_ROLE Qt::UserRole + 2
#define SNAPSHOT_ROLE Qt::UserRole + 3
#define PROGRESS_ROLE Qt::UserRole + 4


PageModel::PageModel(QObject *parent)
    : QStandardItemModel(parent)
{
    QHash<int, QByteArray> roles;
    roles[TITLE_ROLE] = "title";
    roles[URL_ROLE] = "url";
    roles[SNAPSHOT_ROLE] = "snapshot";
    roles[PROGRESS_ROLE] = "progress";
    setRoleNames(roles);

    connect(this, SIGNAL(rowsInserted(const QModelIndex &, int, int)),
            SIGNAL(countChanged()));
    connect(this, SIGNAL(rowsRemoved(const QModelIndex &, int, int)),
            SIGNAL(countChanged()));
}

void PageModel::add(const QString &title, const QString &url)
{
    QStandardItem *item = new QStandardItem(url);
    item->setData(url, URL_ROLE);
    item->setData(title, TITLE_ROLE);
    item->setData(0.0, PROGRESS_ROLE);
    item->setData(QPixmap(), SNAPSHOT_ROLE);
    appendRow(item);
}

void PageModel::remove(int index)
{
    removeRow(index);
}

void PageModel::setUrl(int index, const QString &url)
{
    QStandardItem *obj = item(index);
    if (obj)
        setData(indexFromItem(obj), url, URL_ROLE);
}

void PageModel::setTitle(int index, const QString &title)
{
    QStandardItem *obj = item(index);
    if (obj)
        setData(indexFromItem(obj), title, TITLE_ROLE);
}

void PageModel::setSnapshot(int index, const QPixmap &pixmap)
{
    QStandardItem *obj = item(index);
    if (obj)
        setData(indexFromItem(obj), pixmap, SNAPSHOT_ROLE);
}
