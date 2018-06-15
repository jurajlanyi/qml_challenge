#include "chatserver.h"

ChatServer::ChatServer(QObject *parent) : QObject(parent)
{
    m_allMessages = "no chat session<br>";
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

    m_allMessages += (m_userName + "> " + message + "<br>");
    emit messageChanged();
};

void ChatServer::sendChatMessage(const QString &clientName, const QString &messageText)
{
    m_allMessages += clientName + "> ";
    m_allMessages += messageText;
    m_allMessages += "<br>";
//    emit messageChanged();

    if (clientName == m_userName)
        emit chatUpdate(m_userName2, m_userName, messageText);
    if (clientName == m_userName2)
        emit chatUpdate(m_userName, m_userName2, messageText);
}

void ChatServer::registerChatClient(const QString &clientName)
{
    clients++;
    if (clients == 1)
        m_userName = clientName;
    if (clients == 2)
        m_userName2 = clientName;
    if (clients == 2) {
        m_allMessages = "chat session was established now with " + m_userName + " <br>";
        emit messageChanged();
    }
}
