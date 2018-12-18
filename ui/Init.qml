import QtQuick.Layouts 1.4
import QtQuick 2.4
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import Mycroft 1.0 as Mycroft

Mycroft.Delegate {
    id: initView
    skillBackgroundSource: "https://www.solidbackgrounds.com/images/1920x1080/1920x1080-black-solid-color-background.jpg"
    
    ColumnLayout {
        anchors.fill: parent

        Image {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: Kirigami.Units.gridUnit * 6
            Layout.preferredHeight: Kirigami.Units.gridUnit * 6
            source: Qt.resolvedUrl("Images/Mycroft.png")
            fillMode: Image.PreserveAspectFit
        }    
    }
}
 
