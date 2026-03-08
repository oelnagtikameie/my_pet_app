import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // 需要你在 pubspec.yaml 里加了 http 插件

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {"role": "pet", "content": "哈喽！今天想和我聊点什么？"}
  ];

  // 模拟发送消息给 AI 后端
  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "content": _controller.text});
    });

    String userText = _controller.text;
    _controller.clear();

    // TODO: 这里之后填入你后端同学给你的 URL
    // var response = await http.post(Uri.parse('你的后端API'), body: {'msg': userText});
    
    // 模拟 AI 回复
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _messages.add({"role": "pet", "content": "你说得对，但我只是个演示 AI，等后端接口接好我就能真聊了！"});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("与宠物聊天")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (c, i) => ListTile(
                title: Text(_messages[i]["role"] == "user" ? "我" : "小宠"),
                subtitle: Text(_messages[i]["content"]!),
                leading: CircleAvatar(child: Text(_messages[i]["role"]![0])),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller)),
                IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage),
              ],
            ),
          )
        ],
      ),
    );
  }
}