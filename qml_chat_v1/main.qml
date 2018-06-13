import QtQuick 2.8
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("QML Chat")
    Text {
        id: idWindowHeaderArea
        text: "window text"
        height: parent.height*0.1
    }

    Rectangle {
        id: idUserOneArea
        color: "lightYellow"
        border.width: 2
        border.color: "red"
        width: parent.width-10
        height: parent.height*0.4
        anchors.top: idWindowHeaderArea.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text : "container rectangle user1"
        }
    }

    Rectangle {
        id: idUserTwoArea
        color: "lightGreen"
        border.width: 2
        border.color: "red"
        width: parent.width-10
        height: parent.height*0.4
        anchors.top: idUserOneArea.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            text : "container rectangle user2"
        }
    }
}
