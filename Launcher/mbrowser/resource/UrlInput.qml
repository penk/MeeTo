/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the QtDeclarative module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial Usage
** Licensees holding valid Qt Commercial licenses may use this file in
** accordance with the Qt Commercial License Agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Nokia.
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
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.0

Item {
    id: container

    property alias image: bg.source
    property alias url: urlText
    property alias text: urlText.text

    signal urlEntered(string url)
    signal urlChanged

    width: parent.height; height: parent.height

    BorderImage {
        id: bg; 
        width: if (frame.state == "TopUp" || frame.state == "TopDown") { return 235 } else { return 492} 
        height: 38;
        BorderImage {
            source: "images/inputtext_progress.png"
            width: {  
                if (webView.progress != 1) Math.max(20, bg.width * webView.progress)
                else 0 // clean up progress bar once loaded
            }
            border.left: 10;
            visible: (width > 20);
        }
    }

    TextInput {
        id: urlText
        horizontalAlignment: TextEdit.AlignLeft
        font.pixelSize: 14;
        color: "#646464";

        onTextChanged: container.urlChanged()

        Keys.onEscapePressed: {
            urlText.text = webView.url
            webView.focus = true
        }

        Keys.onEnterPressed: {
            container.urlEntered(urlText.text)
            webView.focus = true
        }

        Keys.onReturnPressed: {
            container.urlEntered(urlText.text)
            webView.focus = true
        }

        anchors {
            left: parent.left; right: parent.right; leftMargin: 10; rightMargin: 25
            verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent;
            anchors.margins: -15;
            onClicked: { parent.focus = true; } 
        }

    }
}
