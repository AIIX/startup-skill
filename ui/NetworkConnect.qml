/*
    Copyright 2017-2019 Aditya Mehra <aix.m@outlook.com>
    Copyright 2013-2017 Jan Grulich <jgrulich@redhat.com>
    
    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) version 3, or any
    later version accepted by the membership of KDE e.V. (or its
    successor approved by the membership of KDE e.V.), which shall
    act as a proxy defined in Section 6 of version 3 of the license.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick.Layouts 1.4
import QtQuick 2.9
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import Mycroft 1.0 as Mycroft

Item {
    id: networkPasswordScreen
    anchors.fill: parent
    
    PlasmaNM.Handler {
        id: handler
    }
    
    Item {
        id: topArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: Kirigami.Units.gridUnit * 2
        
        Kirigami.Heading {
            id: connectionTextHeading
            level: 1
            wrapMode: Text.WordWrap
            anchors.centerIn: parent
            font.bold: true
            text: "Enter Password For " + connectionName
            color: Kirigami.Theme.linkColor
        }
    }
    
    Item {
        anchors.top: topArea.bottom
        anchors.topMargin: Kirigami.Units.largeSpacing
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        
        PlasmaComponents.TextField {
            id: passField
            anchors.top: parent.top
            anchors.topMargin: Kirigami.Units.largeSpacing
            width: parent.width
            height: Kirigami.Units.gridUnit * 3
            property int securityType
            echoMode: TextInput.Password
            revealPasswordButtonShown: true
            placeholderText: i18n("Password...")
            validator: RegExpValidator {
                            regExp: if (securityType == PlasmaNM.Enums.StaticWep) {
                                        /^(?:.{5}|[0-9a-fA-F]{10}|.{13}|[0-9a-fA-F]{26}){1}$/
                                    } else {
                                        /^(?:.{8,64}){1}$/
                                    }
                            }
                            
            onAccepted: {
                 Mycroft.MycroftController.sendText("show connecting screen");
                 handler.addAndActivateConnection(devicePath, specificPath, passField.text)
            }
        }
    }
}
