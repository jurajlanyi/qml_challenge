import QtQuick 2.8
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("QML Chat")
    Text {
        text: "window text"
    }

    Rectangle {
        color: "lightYellow"
        border.width: 2
        border.color: "red"
        width: parent.width-10
        height: parent.height*0.4
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text : "container rectangle"
        }
    }
/*
    Rectangle {
        color: "green"
        border.width: 2
        border.color: "yellow"
        width: parent.width-10
        height: parent.height*0.4
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text : "container rectangle"
        }
    }
*/
}
