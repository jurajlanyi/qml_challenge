#include "chatserver.h"

ChatServer::ChatServer(QObject *parent) : QObject(parent)
{
    m_messageString = "chat session was established now<br>";
    clients = 0;
}

void ChatServer::setMessage(const QString &message)
{
// newest message on top - it does not look goog
//    m_messageString = message + "<br>" + m_messageString;

    if (message.length() == 0)
        return;

    m_messageString += (message + "<br>");
    emit messageChanged();
};

//bool ChatServer::registerChatClient(const QString &clientName)
//{
//    m_messageString = "chat session was established now with " + clientName + " <br>";
//    m_userName = clientName;
//    emit messageChanged();
//    return true;
//}

void ChatServer::registerChatClient(int n)
{
    m_messageString = "chat session register client <br>";
    clients += n;
//    m_userName = clientName;
//    emit messageChanged();
}
