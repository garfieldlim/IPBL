import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// OpenAI Service
class OpenAIService {
  final String _endpoint =
      "https://api.openai.com/v1/engines/davinci/completions";
  final String _apiKey =
      "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"; // REMEMBER: DO NOT hard code this. Use secure storage.

  Future<String> getResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        "Authorization": "Bearer $_apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"prompt": prompt, "max_tokens": 50}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["choices"][0]["text"].trim();
    } else {
      throw Exception('Failed to load response from OpenAI.');
    }
  }
}

// Message Model
class Message {
  final String text;
  final bool byUser;

  Message(this.text, this.byUser);
}

// Buddy Widget
class Buddy extends StatefulWidget {
  const Buddy({Key? key}) : super(key: key); // Corrected this line for the key

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
        title: const Text("Chat with Buddy"),
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
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
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
                    decoration: const InputDecoration(
                      labelText: "Type a message",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
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

  void _sendMessage(String text) async {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(Message(text, true));
      });
      _controller.clear();

      try {
        final service = OpenAIService();
        final response = await service.getResponse(text);
        setState(() {
          _messages.add(Message(response, false));
        });
      } catch (e) {
        print('Error: $e');
        // Handle the error, maybe show a message to the user.
      }
    }
  }
}
