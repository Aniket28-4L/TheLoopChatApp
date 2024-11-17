import 'package:flutter/material.dart';
import 'ai_chat.dart';
import 'ai_api.dart';

class AIChatWidget extends StatefulWidget {
  final AIChat aiChat;

  const AIChatWidget({Key? key, required this.aiChat}) : super(key: key);

  @override
  _AIChatWidgetState createState() => _AIChatWidgetState();
}

class _AIChatWidgetState extends State<AIChatWidget> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = []; // List to store messages

  bool _isLoading = false;

  /// Sends the user message to the AI and updates the chat
  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text.trim();
    _controller.clear();

    // Add user message to chat
    setState(() {
      _messages.add({'role': 'user', 'content': userMessage});
      _isLoading = true;
    });

    try {
      // Get AI's response
      final aiResponse = await widget.aiChat.chat(userMessage);

      setState(() {
        _messages.add({'role': 'ai', 'content': aiResponse});
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'ai', 'content': 'Error: Could not fetch response.'});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      message['content'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _isLoading ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
