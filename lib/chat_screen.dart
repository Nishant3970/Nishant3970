import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isMe: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    // Simulate a reply after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      ChatMessage reply = ChatMessage(
        text: "This is an automated reply to: $text",
        isMe: false,
      ); // ChatMessage
      setState(() {
        _messages.insert(0, reply);
      });
    }); // Future.delayed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Chat'),
      ), // AppBar
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ), // ListView.builder
          ), // Flexible
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ), // Container
        ],
      ), // Column
    ); // Scaffold
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme
          .of(context)
          .colorScheme
          .secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                const InputDecoration.collapsed(hintText: 'Send a message'),
              ), // TextField
            ), // Flexible
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ), // IconButton
          ],
        ), // Row
      ), // Container
    ); // IconTheme
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatMessage({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              child: Text(isMe ? 'Me' : 'Bot'),
            ), // CircleAvatar
          ), // Container
          Expanded(
            child: Column(
              crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(isMe ? 'You' : 'Bot',
                    style: Theme.of(context).textTheme.titleSmall), // Text
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ), // Container
              ],
            ),// Column
          ), // Expanded
        ],
      ),// Row
    ); //Container
  }
}