import 'package:flutter/material.dart';

class TreeHolePage extends StatefulWidget {
  const TreeHolePage({super.key});

  @override
  State<TreeHolePage> createState() => _TreeHolePageState();
}

class _TreeHolePageState extends State<TreeHolePage> {
  String? _mood = '开心';
  final TextEditingController _diaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的树洞")),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/bg_diary.jpg"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              DropdownButton<String>(
                value: _mood,
                items: ['开心', '一般', '难过'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _mood = v),
              ),
              TextField(
                controller: _diaryController,
                maxLines: 10,
                decoration: const InputDecoration(hintText: "今天发生了什么？", fillColor: Colors.white70, filled: true),
              ),
              ElevatedButton(
                onPressed: () {
                  // 这里调用后端 API 发送数据
                  print("保存日记: ${_diaryController.text}, 心情: $_mood");
                },
                child: const Text("保存日记"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}