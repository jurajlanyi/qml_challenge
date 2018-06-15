#include <time.h>

#include "chatserver.h"

ChatServer::ChatServer(QObject *parent) : QObject(parent)
{
    m_allMessages = "no chat session<br>";
    m_userName = "";
    m_userName += "not definied"; // fails ?
    clients = 0;
    sessionActive = 0;
}

/*
void ChatServer::setMessage(const QString &message)
{
// newest message on top - it does not look good
//    m_messageString = message + "<br>" + m_messageString;

    if (message.length() == 0)
        return;

    m_allMessages += (m_userName + "> " + message + "<br>");
    emit messageChanged();
};
*/

void ChatServer::sendChatMessage(const QString &clientName, const QString &messageText)
{
    m_allMessages += clientName + "> ";
    m_allMessages += messageText;
    m_allMessages += "<br>";
//    emit messageChanged();


    for (auto it: chatClients) {
        if (it.first != clientName) {
            emit chatUpdate(it.first, clientName, messageText);
        }
        else {
            it.second.messages++;
            it.second.lastMessage = time(NULL);
        }
    }
//    if (clientName == m_userName)
//        emit chatUpdate(m_userName2, m_userName, messageText);
//    if (clientName == m_userName2)
//        emit chatUpdate(m_userName, m_userName2, messageText);
}

bool ChatServer::registerChatClient(const QString &clientName)
{
    ClientMap::iterator it = chatClients.find(clientName);
    if (it != chatClients.end()) // already registered
        return false;

    ChatClient cc;
    chatClients.insert(std::make_pair(clientName,cc));
    clients++;

    if (clients == 1)
        m_userName = clientName;
    if (clients == 2)
        m_userName2 = clientName;
    if (clients == 2) {
        m_allMessages = "chat session was established now with " + m_userName + " <br>";
        setSessionActive(1);
        emit messageChanged();
    }
    return true;
}

