import 'package:flutter/material.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart'; //

class DressUpPage extends StatefulWidget {
  const DressUpPage({super.key});

  @override
  State<DressUpPage> createState() => _DressUpPageState();
}

class _DressUpPageState extends State<DressUpPage> {
  // UnityWidgetController? _unityController; // 暂时注释掉

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("宠物装扮"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: [
          // 1. 上半部分：Unity 预览区域占位
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              color: Colors.grey[300], // 换成灰色背景，代表 3D 区域还没加载
              child: const Center(
                child: Text(
                  "3D 宠物显示区域\n(由于没有 unityLibrary，暂时占位)",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              // 注意：Container 没有 onUnityCreated 属性，所以这一行必须删掉或注释
              // onUnityCreated: (controller) => _unityController = controller, 
            ),
          ),
          
          // 2. 下半部分：换装选择器
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
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
        // 既然注释了 Unity，这里改用打印来模拟点击效果
        debugPrint("你点击了换装项目：$label, ID为: $partID");
        
        // 由于 _unityController 被注释了，下面这行也必须注释，否则会报错
        // _unityController?.postMessage("ModelManager", "ChangePart", partID);
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