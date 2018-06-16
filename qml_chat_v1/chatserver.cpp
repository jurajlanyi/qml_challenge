#include <time.h>

#include "chatserver.h"

ChatServer::ChatServer(QObject *parent) : QObject(parent)
{
    m_allMessages = "no chat session<br>";
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

// clientName - who is sending message
void ChatServer::sendChatMessage(const QString &clientName, const QString &messageText)
{
    m_allMessages += clientName + "> ";
    m_allMessages += messageText;
    m_allMessages += "<br>";

    // emit messageChanged(); // Old way to send whole chat to all clients

    m_status = "Chat ";
    m_status += ((chatClients.size() >=2 ) ? "active | " : "inactive | ");

    for (auto it: chatClients) {
        m_status += it.first;                               // Add client name
        char str[128];
        sprintf(str, " messages:%d |", it.second.messages+(it.first == clientName)); // +1 as we are about to send one
        m_status += str;
    }

    for (ClientMap::iterator it=chatClients.begin(); it != chatClients.end(); it++)
    {
        if (it->first != clientName) {
            emit chatUpdate(it->first, clientName, messageText, m_status);
        }
        else {
            it->second.messages++;
            it->second.lastActive = time(NULL);
        }
    }
}

bool ChatServer::registerChatClient(const QString &clientName)
{
    ClientMap::iterator it = chatClients.find(clientName);
    if (it != chatClients.end()) // already registered
        return false;

    ChatClient cc;
    cc.lastActive = time(NULL);
    chatClients.insert(std::make_pair(clientName,cc));

    int clients = chatClients.size();

    if (clients == 2) {
        m_allMessages = "chat session was established now";
        setSessionActive(1);
        emit messageChanged();
    }
    return true;
}

void ChatServer::setSessionActive(int act)
{
    if (sessionActive != act) {
        sessionActive = act;
        emit sessionActiveChanged();
    }
};

