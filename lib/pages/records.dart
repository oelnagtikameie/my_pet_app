import 'package:flutter/material.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  // 这里的变量可以用来存储输入的信息
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _petNameController = TextEditingController();
  String _petGender = '男';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("个人记录")),
      body: Container(
        // 这里记得之后替换成你们自己的背景图
        decoration: const BoxDecoration(color: Colors.white), 
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _userNameController, decoration: const InputDecoration(labelText: "主人姓名")),
            TextField(controller: _petNameController, decoration: const InputDecoration(labelText: "宠物姓名")),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text("宠物性别："),
                DropdownButton<String>(
                  value: _petGender,
                  items: ['男', '女'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setState(() => _petGender = v!),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(onPressed: () {
              // 这里之后写连接后端的逻辑
              print("保存信息成功");
            }, child: const Text("保存")),
          ],
        ),
      ),
    );
  }
}