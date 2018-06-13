#ifndef CHATSERVER_H
#define CHATSERVER_H

#include <QObject>

class ChatServer : public QObject
{
    Q_OBJECT
    // message property accumulates whole chat history
    Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged)


public:
    explicit ChatServer(QObject *parent = nullptr);
    Q_INVOKABLE bool registerChatClient(const QString &clientName);

    QString message() { return m_messageString; };
    void setMessage(const QString &message); // { m_messageString = message + "<br>" + m_messageString; emit messageChanged(); };

signals:
    void chatUpdate();          // TODO: chat content was updated
    void messageChanged();      // chat content changed

public slots:

private:
    QString m_messageString;    // all chat messages
    QString m_userName;         // chat user name
};

#endif // CHATSERVER_H
