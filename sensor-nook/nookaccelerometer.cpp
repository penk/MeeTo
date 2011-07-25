/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial Usage
** Licensees holding valid Qt Commercial licenses may use this file in 
** accordance with the Qt Commercial License Agreement provided with
** the Software or, alternatively, in accordance with the terms
** contained in a written agreement between you and Nokia.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights.  These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
** If you are unsure which license is appropriate for your use, please
** contact the sales department at qt-sales@nokia.com.
** $QT_END_LICENSE$
**
****************************************************************************/

#include "nookaccelerometer.h"
#include <QFile>
#include <QDebug>
#include <time.h>
#include <stdio.h>

#include <stdint.h>

#include <linux/input.h>

#include <string.h>
#include <fcntl.h>
#include <unistd.h>


char const * const nookaccelerometer::id("nook.accelerometer");
char const * const nookaccelerometer::filename("/dev/input/event3");

nookaccelerometer::nookaccelerometer(QSensor *sensor)
    : nookfilebasedsensor(sensor)
{
    setReading<QAccelerometerReading>(&m_reading);
    // Details derived from the kernel driver
    addDataRate(100, 100); // 100Hz
    addOutputRange(-22.418, 22.418, 0.17651); // 2G
    setDescription(QLatin1String("kxtf9"));
}

void nookaccelerometer::start()
{
    if (!QFile::exists(QLatin1String(filename)))
        goto error;

    nookfilebasedsensor::start();
    return;

error:
    sensorStopped();
}

void nookaccelerometer::poll()
{
    // Note that this is a rather inefficient way to generate this data.
    // Ideally the kernel would scale the hardware's values to m/s^2 for us
    // and give us a timestamp along with that data.

    int rd, fd, i;
    struct input_event ev[64];

    fd = open(filename, O_RDONLY);
    if (fd<0) return;

    rd = read(fd, ev, sizeof(struct input_event) * 64);

    if (rd < (int) sizeof(struct input_event)) {
        printf("yyy\n");
        perror("\nevtest: error reading");
        return;
    }

    int x, y, z;

    for (i = 0; i < rd / sizeof(struct input_event); i++)

        if (ev[i].type == 2) { // Relative

            if (ev[i].code == 0) x = ev[i].value;
            if (ev[i].code == 1) y = ev[i].value;
            if (ev[i].code == 2) z = ev[i].value;

        }

    // Convert from milli-Gs to meters per second per second
    // Using 1 G = 9.80665 m/s^2
    qreal ax = x * 0.00980665;
    qreal ay = y * -0.00980665;
    qreal az = z * -0.00980665;

    m_reading.setTimestamp(clock());
    m_reading.setX(ax);
    m_reading.setY(ay);
    m_reading.setZ(az);

    newReadingAvailable();
}

