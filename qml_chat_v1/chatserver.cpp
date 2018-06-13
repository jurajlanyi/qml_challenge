#include "chatserver.h"

ChatServer::ChatServer(QObject *parent) : QObject(parent)
{
    m_messageString = "chat session was established now<br>";
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
