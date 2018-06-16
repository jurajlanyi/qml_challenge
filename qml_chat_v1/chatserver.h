#ifndef CHATSERVER_H
#define CHATSERVER_H

#include <QObject>

// Chat client is identified in ChatServer by the name he has chosen when registering

// ChatClient: Associated information with chat client
class ChatClient                            // derive from QObject ?
{
public:
    ChatClient() : messages(0), lastActive(0) {};
private:
    int messages;                                           // messages sent
    time_t lastActive;                                      // last activity. automatic kick-off after timeout ???
friend class ChatServer;
};


class ChatServer : public QObject
{
    Q_OBJECT

// Now OBSOLETE: message property accumulates whole chat history, each write adds message
// Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged)
// TODO: rename, if needed at all
    Q_PROPERTY(QString message READ message WRITE setMessageNone NOTIFY messageChanged)

    Q_PROPERTY(int sessionActive READ getSessionActive WRITE setSessionActive NOTIFY sessionActiveChanged)

public:
    explicit ChatServer(QObject *parent = nullptr);

    Q_INVOKABLE bool registerChatClient(const QString &clientName);
    Q_INVOKABLE void sendChatMessage(const QString &clientFromName, const QString &messageText);

    QString message() { return m_allMessages; };
//    void setMessage(const QString &message); // { m_messageString = message + "<br>" + m_messageString; emit messageChanged(); };
    void setMessageNone(const QString &message) { }; // Does nothing by purpose

    int getSessionActive() { return sessionActive; };
    void setSessionActive(int act);

private:
    QString m_allMessages;                                  // all chat messages
    int sessionActive;                                      // are at least 2 members active ?
    QString m_status;                                       // Text status for the chat

    typedef std::map<QString, ChatClient> ClientMap;
    ClientMap chatClients;                                  // Registered clients are stored here

public:

signals:
    void chatUpdate(QString msgTo, QString msgFrom, QString msgText, QString strStatus);        // TODO: chat content was updated
    void messageChanged();                                  // chat content changed
    void sessionActiveChanged();

public slots:

};

#endif // CHATSERVER_H
