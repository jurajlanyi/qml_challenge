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

    if (clients > 0)
        m_messageString += userName;

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

//void ChatServer::registerChatClient(int n, QString clname)
bool ChatServer::registerChatClient(int n, const QString & clname)
{
//    m_messageString = "chat session register client <br>";
    clients += n;
//    userName = "some client";
    userName = clname;
//    m_userName = clientName;

    emit messageChanged();
    return true;
}
