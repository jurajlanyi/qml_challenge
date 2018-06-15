#include "chatserver.h"

ChatServer::ChatServer(QObject *parent) : QObject(parent)
{
    m_messageString = "no chat session<br>";
    m_userName = "";
    m_userName += "not definied"; // fails ?
    clients = 0;
}

void ChatServer::setMessage(const QString &message)
{
// newest message on top - it does not look good
    //    m_messageString = message + "<br>" + m_messageString;

    if (message.length() == 0)
        return;

//    m_messageString += (m_userName + "> " + message + "<br>");

    m_messageString += m_userName;
    m_messageString += ("> " + message + "<br>");
    emit messageChanged();
};

bool ChatServer::registerChatClient(const QString &clientName)
{
    clients++;
//    m_userName += "aaa";
//    m_userName = m_userName + "aaa";
    m_userName = clientName;
    if (clients >= 2) {
        m_messageString = "chat session was established now with " + clientName + " <br>";
//        m_userName = clientName;
        emit messageChanged();
    }
    return true;
}
