import QtQuick.Layouts 1.4
import QtQuick 2.9
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import Mycroft 1.0 as Mycroft

Mycroft.Delegate {
    id: networkPasswordScreen
    skillBackgroundSource: "http://www.baltana.com/files/wallpapers-1/Plain-Blue-Wallpaper-00476.jpg"
    
    ColumnLayout{
    anchors.top: parent.top
    anchors.topMargin: Kirigami.Units.largeSpacing
    anchors.left: parent.left
    anchors.right: parent.right
    height: parent.height / 2
    spacing: Kirigami.Units.smallSpacing
    
        Kirigami.Heading {
            id: wirelessPassLabel
            level: 2
            text: "Enter Wireless Password For " + sessionData.ConnectionName
            Layout.fillWidth: true
            wrapMode: Text.WordWrap;
            font.bold: true;
            color: Kirigami.Theme.textColor;
        }
    
        PlasmaComponents.TextField {
            property int securityType
            Layout.fillWidth: true
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
        }
    }
}
