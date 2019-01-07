import QtQuick.Layouts 1.4
import QtQuick 2.4
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import Mycroft 1.0 as Mycroft

import org.kde.lottie 1.0


Item {
    id: successView
    anchors.fill: parent
    
    ColumnLayout {
        anchors.fill: parent
        LottieAnimation {
            id: l1
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: Qt.resolvedUrl("Animations/success.json")
            loops: 0
            fillMode: Image.PreserveAspectFit
            running: true
            
            onSourceChanged: {
                console.log(l1.status)
            }
        }    
    }
}
 
