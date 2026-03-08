import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class DressUpPage extends StatefulWidget {
  const DressUpPage({super.key});

  @override
  State<DressUpPage> createState() => _DressUpPageState();
}

class _DressUpPageState extends State<DressUpPage> {
  UnityWidgetController? _unityController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("宠物装扮"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          // 1. 上半部分：Unity 区域
          Expanded(
            flex: 5,
            child: UnityWidget(
              onUnityCreated: (controller) => _unityController = controller,
            ),
          ),
          
          // 2. 下半部分：换装选择器
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), 
                  topRight: Radius.circular(30)
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)
                ],
              ),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  // 注意：这里去掉了 const 关键字，修正了图标拼写
                  _dressItem("帽子", "hat_01", Icons.checkroom),
                  _dressItem("眼镜", "glasses_01", Icons.visibility),
                  _dressItem("衣服", "clothes_01", Icons.accessibility_new),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 每一个换装小格子组件
  Widget _dressItem(String label, String partID, IconData icon) {
    return GestureDetector(
      onTap: () {
        // 向 Unity 发送换装指令
        _unityController?.postMessage("ModelManager", "ChangePart", partID);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.orange, size: 30),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}