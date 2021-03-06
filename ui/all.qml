import QtQuick.Layouts 1.4
import QtQuick 2.4
import QtQuick.Controls 2.0
import org.kde.kirigami 2.5 as Kirigami
import Mycroft 1.0 as Mycroft

Mycroft.Delegate {
    id: mainLoaderView
    anchors.fill: parent
    skillBackgroundSource: Qt.resolvedUrl("bg.png")
    property var pageToLoad: sessionData.state
    property var securityType: sessionData.SecurityType
    property var connectionName: sessionData.ConnectionName
    property var devicePath: sessionData.DevicePath
    property var specificPath: sessionData.SpecificPath
    property var idleScreenList: sessionData.idleScreenList
    
    Loader {
        id: rootLoader
        anchors.fill: parent
    }
    
    onPageToLoadChanged: {
        console.log(sessionData.state)
        rootLoader.setSource(sessionData.state + ".qml")
    }
}
