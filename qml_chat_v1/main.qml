import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

import io.qt.examples.chatserver 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("QML Chat")

    ChatServer {
        id: chatserver
//        message: "no message"
    }

    Text {
        id: idWindowHeaderArea
        text: "window text - idWindowHeaderArea"
        color: "red"
        height: parent.height*0.1
    }

    Rectangle {
        id: idUserOneArea
        color: "lightYellow" ; border.width: 2 ; border.color: "red"
        width: parent.width-10
        height: parent.height*0.4
        anchors.top: idWindowHeaderArea.bottom ; anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        property string my_name: ""
        Text {
            id: idUserOneChatHeader
            text : "container rectangle user1 chat elements"
        }
        // Area where chat messages are listed
        TextEdit {
            id: idUserOneChatDisplay
            textFormat: Text.RichText
            text: qsTr("Chat user 1")
            anchors.top: idUserOneChatHeader.bottom
            readOnly: true
            font.family: "Helvetica"; font.pointSize: 8
            color: "blue"
        }

        // Element to enter message
        TextField {
            id: idUserOneInput
            width: parent.width-10
            placeholderText: qsTr("Enter your name")
            font.pointSize: 12
            anchors { bottom: parent.bottom ; left: parent.left ; bottomMargin: 5 ; leftMargin: 5 }
            property bool isInit: false                     // was chat user name entered ?
            onAccepted : {
                if (text.length > 0) {
                    if (!isInit) { // Register with entered name
                        chatserver.registerChatClient(text)
                        isInit = true
                        parent.my_name = text; text = "";
                        placeholderText = "Enter your message here"
                    }
                    else {
                        chatserver.sendChatMessage(parent.my_name, text);
                        console.log("ONE: sending message, my name is: ", parent.my_name);
//                        chatserver.message = text         // relay message to chatserver object
                        idUserOneInput.text = ""            // empty input field
                    }
                }
            }
        }
    }

    Rectangle {
        id: idUserTwoArea
        color: "lightGreen" ; border.width: 2 ; border.color: "red"
        width: parent.width-10
        height: parent.height*0.4
        anchors.top: idUserOneArea.bottom ; anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
//Component.onCompleted: chatserver.registerChatClient("robot") // automatic registration
        property string my_name: ""
        Text {
            id : idUserTwoChatHeader
            text : "container rectangle user2 chat elements"
        }
        // Area where chat messages are listed
        TextEdit {
            id: idUserTwoChatDisplay
            textFormat: Text.RichText
            text: qsTr("Chat user 2")
            anchors.top: idUserTwoChatHeader.bottom
            readOnly: true
            font.family: "Helvetica"; font.pointSize: 8
            color: "black"
        }
        TextField {
            id: idUserTwoInput
            width: parent.width-10
            placeholderText: qsTr("Enter your name")
            font.pointSize: 12
            property bool isInit: false                     // was chat user name entered ?
            onAccepted : {
                if (text.length > 0) {
                    if (!isInit) { // Register with entered name
                        chatserver.registerChatClient(text)
                        isInit = true
                        parent.my_name = text; text = "";
                        placeholderText = "Enter your message here"
                    }
                    else {
                        chatserver.sendChatMessage(parent.my_name, text);
                        console.log("TWO: sending message, my name is: ", parent.my_name);
                        idUserOneInput.text = ""        // empty input field
                    }
                }
            }
        }
    }

    Connections {
        target: chatserver
        onMessageChanged: {                 // reaction to ChatServer signal
            // todo parse arguments, if any
            idUserOneChatDisplay.text = chatserver.message
            idUserTwoChatDisplay.text = chatserver.message
        }
    }
}
