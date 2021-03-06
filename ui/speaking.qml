import QtQuick.Layouts 1.4
import QtQuick 2.4
import QtQuick.Controls 2.0
import org.kde.kirigami 2.4 as Kirigami

import Mycroft 1.0 as Mycroft

Item {
    function getVisemeImg(viseme){
        return "face/" + viseme + ".svg"
    }

    function getVisemeWidth(viseme){
        switch (viseme) {
            case "0": return 290 / 2;
            case "1": return 130 / 2;
            case "2": return 250 / 2;
            case "3": return 170 / 2;
            case "4": return 60 / 2;
            case "5": return 110 / 2;
            case "6": return 90 / 2;
        }
    }
    Item {
        id: top_spacing
        anchors.top: parent.top
        height: 176
    }
    Rectangle {
        id: eyes
        anchors.top: top_spacing.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: 141
        color: "#00000000"
        Rectangle {
            id: rectangle
            anchors.left: parent.left
            anchors.leftMargin: 12
            width: 141
            color: "#00000000"
            Image {
                id: left_eye
                anchors.horizontalCenter: parent.horizontalCenter
                y: 0
                width: 141
                source: Qt.resolvedUrl("face/Eyeball.svg")
                fillMode: Image.PreserveAspectFit
            }
            Image {
                id: left_eye_upper
                anchors.horizontalCenter: parent.horizontalCenter
                width: 141
                fillMode: Image.PreserveAspectFit
                source: Qt.resolvedUrl("face/upper-lid.svg")
            }
        } 
        Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: 12
            id: rectangle2
            width: 141
            color: "#00000000"

            Image {
                id: right_eye
                anchors.horizontalCenter: parent.horizontalCenter
                width: 141
                fillMode: Image.PreserveAspectFit
                source: Qt.resolvedUrl("face/Eyeball.svg")
            }
            Image {
                id: right_eye_upper
                anchors.horizontalCenter: parent.horizontalCenter
                width: 141
                fillMode: Image.PreserveAspectFit
                source: Qt.resolvedUrl("face/upper-lid.svg")
            }
        }
    }
    
    Item {
        id: mid_spacing
        anchors.top: eyes.bottom
        height: 112
    }

    Rectangle {
        id: mouth_rectangle
        anchors.top: mid_spacing.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: 266
        height: 115
        color: "#00000000"
    }
    Rectangle {
        id: mouth_viseme
        anchors.verticalCenter: mouth_rectangle.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: 40
        height: width
        radius: width / 2
        color: "black"
        border.color: "white"
        border.width: 20
    }
    Rectangle {
        id: smile
        anchors.verticalCenter: mouth_rectangle.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        color: "black"
        width: 266
        height: 100
        Image {
            id: smile_img
            anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            width: 266
            source: Qt.resolvedUrl(getVisemeImg("Smile"))
        }
    }

    PropertyAnimation {
        id: anim
        target: mouth_viseme
        property: "width"
        to: 40
        duration: 50
    }
    Timer {
	id: tmr
	interval: 50 // every 50 ms
	running: true
	repeat: true
        onTriggered: {
            var now = Date.now() / 1000;
            var start = sessionData.viseme.start;
            var offset = start;
            // Compare viseme start/stop with current time and choose viseme
            // appropriately
            for (var i = 0; i < sessionData.viseme.visemes.length; i+=2) {
                if (sessionData.viseme.start == 0)
                    break;
                if (now >= offset &&
                        now < start + sessionData.viseme.visemes[i][1])
                {
                    smile.visible = false
                    anim.to = getVisemeWidth(sessionData.viseme.visemes[i][0]);
                    anim.running = true
                    offset = start + sessionData.viseme.visemes[i][1];
                    return
                }
            }
            smile.visible = true
            // Outside of span show default smile
            //return Qt.resolvedUrl(getVisemeImg("Smile"));
        }
    }
}
