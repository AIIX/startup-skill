import QtQuick.Layouts 1.4
import QtQuick 2.9
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import Mycroft 1.0 as Mycroft

Mycroft.Delegate {
    id: networkPasswordScreen
    skillBackgroundSource: "https://www.solidbackgrounds.com/images/1920x1080/1920x1080-black-solid-color-background.jpg"
    
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
            text: "Enter Password For " + sessionData.ConnectionName 
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
                            regExp: if (sessionData.SecurityType == PlasmaNM.Enums.StaticWep) {
                                        /^(?:.{5}|[0-9a-fA-F]{10}|.{13}|[0-9a-fA-F]{26}){1}$/
                                    } else {
                                        /^(?:.{8,64}){1}$/
                                    }
                            }
                            
            onAccepted: {
                 Mycroft.MycroftController.sendText("show connecting screen");
                 handler.addAndActivateConnection(sessionData.DevicePath, sessionData.SpecificPath, passField.text)
            }
        }
    }
}
