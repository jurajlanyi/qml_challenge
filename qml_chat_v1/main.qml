import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
//import QtQuick.Controls 2.1

import io.qt.examples.chatserver 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("QML Chat")

    ChatServer {
        id: chatserver
    }

    Text {
        id: idWindowHeaderArea
        text: "window text - idWindowHeaderArea"
        color: "red"
//        height: parent.height*0.1
    }
    Text {
        id: idUsernameOne
        text: "User One Name"
        font.pointSize: 12
        color: "black"
//        height: parent.height*0.1
        anchors.top: idWindowHeaderArea.bottom ; anchors.topMargin: 1
        anchors.left: idUserOneArea.left
    }

    Rectangle {
        id: idUserOneArea
//        clip: true
        color: "lightYellow" ; border.width: 2 ; border.color: "red"
        width: parent.width-10
        height: parent.height*0.35
//        anchors.top: idWindowHeaderArea.bottom ; anchors.topMargin: 5
        anchors.top: idUsernameOne.bottom ; anchors.topMargin: 2
        anchors.horizontalCenter: parent.horizontalCenter
        property string my_name: ""

        Text {
            id: idUserOneChatHeader
            text : "container rectangle user1 chat elements"
            anchors.top : parent.top

        }
//        // Area where chat messages are listed
//        TextEdit {
//            id: idUserOneChatDisplay
//            textFormat: Text.RichText
//            text: qsTr("Chat user 1")
//            anchors.top: idUserOneChatHeader.bottom
////            anchors.bottom: idUserOneInput.top
//            anchors.margins: 2
//            height : parent.height*0.5
//wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
//            readOnly: true
//            font.family: "Helvetica"; font.pointSize: 8
//            color: "blue"
//        }

ScrollView {
            anchors.top: idUserOneChatHeader.bottom
            anchors.bottom: idUserOneInput.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 2
//            height : parent.height*0.5

        // Area where chat messages are listed
        TextEdit {
            id: idUserOneChatDisplay
            textFormat: Text.RichText
//            text: qsTr("Chat user 1")
//wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            readOnly: true
            font.family: "Helvetica"; font.pointSize: 8
            color: "blue"
        }
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
                        if (chatserver.registerChatClient(text)) {
                            isInit = true
                            parent.my_name = text; idUsernameOne.text = text;
                            placeholderText = "Enter your message here"
                        }
                    }
                    else if (chatserver.sessionActive) {
                        console.log("ONE: sending message, my name is: ", parent.my_name);
                        chatserver.sendChatMessage(parent.my_name, text);
                        idUserOneChatDisplay.text += ("me>" + text)
                    }
                    text = ""
                }
            }
        }

    }

    //Component.onCompleted: chatserver.registerChatClient("robot") // idea to register automatically

    Text {
        id: idUsernameTwo
        text: "User Two Name"
        font.pointSize: 12
        color: "black"
//        height: parent.height*0.1
        anchors.top: idUserOneArea.bottom ; anchors.topMargin: 8
        anchors.left: idUserTwoArea.left
    }

    Rectangle {
        id: idUserTwoArea
//        clip: true

        color: "lightGreen" ; border.width: 2 ; border.color: "red"
//        width: parent.width-10
        width: parent.width*0.8
        height: parent.height*0.35
        anchors.top: idUsernameTwo.bottom ; anchors.topMargin: 2
//        anchors.top: idUserOneArea.bottom ; anchors.topMargin: 50
//        anchors.bottom: parent.bottom ; anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        property string my_name: ""
        Text {
            id : idUserTwoChatHeader
            text : "container rectangle user2 chat elements"
            anchors.top: parent.top
        }
        // Area where chat messages are listed
        TextEdit {
            id: idUserTwoChatDisplay
            textFormat: Text.RichText
            text: qsTr("Chat user 2")
            anchors.top: idUserTwoChatHeader.bottom
            anchors.bottom: idUserTwoInput.top
            anchors.margins: 2
//            height : parent.height*0.5
            readOnly: true
            clip: true
            font.family: "Helvetica"; font.pointSize: 8
            color: "black"
        }
        TextField {
            id: idUserTwoInput
            width: parent.width-10
            placeholderText: qsTr("Enter your name")
            font.pointSize: 12
            property bool isInit: false                     // was chat user name entered ?
            anchors { bottom: parent.bottom ; left: parent.left ; bottomMargin: 5 ; leftMargin: 5 }
            onAccepted : {
                if (text.length > 0) {
                    if (!isInit) { // Register with entered name
                        if (chatserver.registerChatClient(text)) {
                            isInit = true
                            parent.my_name = text; idUsernameTwo.text = text;
                            placeholderText = "Enter your message here"
                        }
                    }
                    else if (chatserver.sessionActive) {
                        console.log("TWO: sending message, my name is: ", parent.my_name);
                        chatserver.sendChatMessage(parent.my_name, text);
                        idUserTwoChatDisplay.text += ("me>" + text)
                    }
                    text = ""                               // empty input field
                }
            }
        }
    }

    Connections {
        target: chatserver
        onMessageChanged: {                                 // reaction to ChatServer signal
            // todo parse arguments, if any
            idUserOneChatDisplay.text = chatserver.message
            idUserTwoChatDisplay.text = chatserver.message
        }
        onChatUpdate: {                                     // ChatServer signal delivers new message
            // todo parse arguments, if any
            console.log("onChatUpdate msg to " + msgTo + " from " + msgFrom)
            if (msgTo == idUserOneArea.my_name)
                idUserOneChatDisplay.text += (msgFrom + ">" + msgText)
            if (msgTo == idUserTwoArea.my_name)
                idUserTwoChatDisplay.text += (msgFrom + ">" + msgText)
        }
    }
}
