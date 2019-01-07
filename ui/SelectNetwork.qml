import QtQuick.Layouts 1.4
import QtQuick 2.4
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import Mycroft 1.0 as Mycroft

Item {
    id: networkSelectionView
    anchors.fill: parent
    property var pathToRemove
        
    function removeConnection(){
        handler.removeConnection(pathToRemove)
    }
    
    PlasmaNM.NetworkStatus {
        id: networkStatus
    }

    PlasmaNM.ConnectionIcon {
        id: connectionIconProvider
    }

    PlasmaNM.Handler {
        id: handler
    }

    PlasmaNM.AvailableDevices {
        id: availableDevices
    }

    PlasmaNM.NetworkModel {
        id: connectionModel
    }

    PlasmaNM.AppletProxyModel {
        id: appletProxyModel
        sourceModel: connectionModel
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
            text: "Select Your Wi-Fi"
            color: Kirigami.Theme.linkColor
        }
    }

    Item {
        anchors.top: topArea.bottom
        anchors.topMargin: Kirigami.Units.largeSpacing
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        
        ListView {
            id: connectionView
            property bool availableConnectionsVisible: true
            anchors.fill: parent
            clip: true
            model: appletProxyModel
            currentIndex: -1
            boundsBehavior: Flickable.StopAtBounds
            delegate: NetworkItem{}
        }
    }
    
    Kirigami.OverlaySheet {
        id: networkActions
        leftPadding: 0
        rightPadding: 0
        parent: networkSelectionView
         
        ColumnLayout {
            implicitWidth: Kirigami.Units.gridUnit * 25
            spacing: 0 
         
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                
                Label {
                    anchors.centerIn: parent
                    text: "Forget Network"
                }
                
                MouseArea {
                    anchors.fill: parent
                    
                    onClicked: {
                        removeConnection()
                        networkActions.close()
                    }
                }
            }
        }
    }
}
