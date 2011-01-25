/****************************************************************************
**
** Copyright (C) 2010 Instituto Nokia de Tecnologia (INdT)
**
** This file is part of the Rask Browser project.
**
** This file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** the openBossa stream from INdT <renato.chencarek@openbossa.org>.
**
****************************************************************************/

#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QDeclarativeItem>
#include <QDeclarativeView>


class MainWindow : public QDeclarativeView
{
    Q_OBJECT

public:
    MainWindow();

protected:
    void setupWebSettings();
    void resizeEvent(QResizeEvent * event);

private:
    QDeclarativeItem *rootItem;
};

#endif
