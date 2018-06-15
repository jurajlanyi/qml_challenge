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

    QString message() { return m_messageString; };
    void setMessage(const QString &message); // { m_messageString = message + "<br>" + m_messageString; emit messageChanged(); };

//    Q_INVOKABLE bool registerChatClient(const QString &clientName);
    Q_INVOKABLE void registerChatClient(int n);

signals:
    void chatUpdate(); // TODO: chat content was updated
    void messageChanged(); // chat content changed

public slots:

private:
    QString m_messageString;
    int clients;
};

#endif // CHATSERVER_H
