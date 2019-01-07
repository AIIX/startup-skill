import QtQuick.Layouts 1.4
import QtQuick 2.4
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import Mycroft 1.0 as Mycroft

Mycroft.Delegate {
    id: mainLoaderView
    skillBackgroundSource: Qt.resolvedUrl("Images/bg.png")
    property var pageToLoad: sessionData.LoaderPage
    property var securityType: sessionData.SecurityType
    property var connectionName: sessionData.ConnectionName
    property var devicePath: sessionData.DevicePath
    property var specificPath: sessionData.SpecificPath 
    
    Loader {
        id: rootLoader
        anchors.fill: parent
    }
    
    onPageToLoadChanged: {
        rootLoader.setSource(sessionData.LoaderPage)
    }
}
