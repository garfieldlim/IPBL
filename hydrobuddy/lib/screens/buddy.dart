import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Buddy()));

class Message {
  final String text;
  final bool byUser;

  Message(this.text, this.byUser);
}

class Buddy extends StatefulWidget {
  @override
  _BuddyState createState() => _BuddyState();
}

class _BuddyState extends State<Buddy> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with Buddy"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final alignment = message.byUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft;
                return Align(
                  alignment: alignment,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          message.byUser ? Colors.blue[100] : Colors.green[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(message.text),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Type a message",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(Message(text, true));
      });
      _controller.clear();

      // A simple Buddy response logic
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _messages
              .add(Message("Hello! I'm Buddy. How can I assist you?", false));
        });
      });
    }
  }
}
