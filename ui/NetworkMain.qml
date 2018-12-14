import QtQuick.Layouts 1.4
import QtQuick 2.4
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import Mycroft 1.0 as Mycroft

Mycroft.ScrollableDelegate {
    id: networkSelectionView
    
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
        
    Kirigami.CardsListView {
        id: connectionView
        property bool availableConnectionsVisible: true
        anchors.fill: parent
        clip: false
        model: appletProxyModel
        currentIndex: -1
        boundsBehavior: Flickable.StopAtBounds
        delegate: NetworkItem{}
    }
}
