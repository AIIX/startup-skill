import QtQuick.Layouts 1.4
import QtQuick 2.4
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import Mycroft 1.0 as Mycroft

import org.kde.lottie 1.0


Item {
    id: connectingView
    //skillBackgroundSource: "https://www.solidbackgrounds.com/images/1920x1080/1920x1080-black-solid-color-background.jpg"
    anchors.fill: parent
    property int connectedStatus 
    property int disconnectedStatus
    
    PlasmaNM.NetworkStatus {
        id: networkStatus
        onNetworkStatusChanged: {
            console.log(networkStatus.networkStatus)
            if(networkStatus.networkStatus == "Connected"){
                connectedStatus = 1
                disconnectedStatus = 0
            }
            if(networkStatus.networkStatus == "Disconnected"){
                disconnectedStatus = 1
                connectedStatus = 0
            }
        }
    }
    
    Connections {
        target: connectedStatus
        onConnectedStatusChanged: {
            if(connectedStatus == 1){
                Mycroft.MycroftController.sendText("show connected screen");
            }
        }
    }
    
    Connections {
        target: disconnectedStatus
        onDisconnectedStatusChanged: {
            if(disconnectedStatus == 1){
                Mycroft.MycroftController.sendText("show fail screen");
            }
        }
    }
    
    ColumnLayout {
        anchors.fill: parent
    
        Item {
            id: topArea
            Layout.fillWidth: true
            Layout.preferredHeight: Kirigami.Units.gridUnit * 2
            
            Kirigami.Heading {
                id: connectionTextHeading
                level: 1
                wrapMode: Text.WordWrap
                anchors.centerIn: parent
                font.bold: true
                text: "Connecting To Wi-Fi"
                color: Kirigami.Theme.linkColor
            }
        }
        
        LottieAnimation {
            id: l1
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: Qt.resolvedUrl("Animations/connecting.json")
            loops: Animation.Infinite
            fillMode: Image.PreserveAspectFit
            running: true
            
            onSourceChanged: {
                console.log(l1.status)
            }
        }    
    }
}
 
