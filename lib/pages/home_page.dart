import 'package:flutter/material.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart'; //
import 'records.dart';     // 记录页
import 'dress_up.dart';    // 装扮页
import 'chat_page.dart';   // 聊天页
import 'tree_hole.dart';   // 树洞页

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // UnityWidgetController? _unityWidgetController; // 暂时注释
  final int _heartCount = 105; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. 底层：暂时用背景图或颜色块代替 Unity 场景
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlueAccent, Colors.lightGreenAccent],
              ),
            ),
            child: const Center(
              child: Text("3D 场景占位\n(Unity 导出后恢复)", textAlign: TextAlign.center),
            ),
          ),
          /* 以后恢复 Unity 时用这段：
          UnityWidget(
            onUnityCreated: (controller) => _unityWidgetController = controller,
            onUnityMessage: (message) => debugPrint("Unity Message: $message"),
          ),
          */

          // 2. 上层：Flutter UI 按钮
          _buildTopUI(),
          _buildSideButtons(),
        ],
      ),
    );
  }

  // 左上角血条/状态
  Widget _buildTopUI() {
    return Positioned(
      top: 50, left: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: Colors.white70, border: Border.all(width: 2)),
        child: Row(
          children: [
            Text('$_heartCount ❤️', style: const TextStyle(fontWeight: FontWeight.bold)),
            const Icon(Icons.add_circle, size: 20, color: Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildSideButtons() {
    return Stack(
      children: [
        // 右上角：装扮、记录
        Positioned(
          top: 50, right: 20,
          child: Column(
            children: [
              _squareButton("装扮", "assets/images/dress_up_btn.png", () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const DressUpPage()));
              }), 
              const SizedBox(height: 10),
              _squareButton("记录", "assets/images/record_btn.png", () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const RecordsPage()));
              }),
            ],
          ),
        ),
        
        // 左下角：个性化、聊天
        Positioned(
          bottom: 100, left: 20,
          child: Column(
            children: [
              _squareButton("个性化", "assets/images/personal_btn.png", () {}),
              const SizedBox(height: 10),
              _squareButton("聊天", "assets/images/chat_btn.png", () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const ChatPage()));
              }),
            ],
          ),
        ),

        // 右下角：树洞、小游戏
        Positioned(
          bottom: 100, right: 20,
          child: Column(
            children: [
              _squareButton("树洞", "assets/images/tree_hole_btn.png", () {
                Navigator.push(context, MaterialPageRoute(builder: (c) => const TreeHolePage()));
              }),
              const SizedBox(height: 10),
              _squareButton("小游戏", "assets/images/game_btn.png", () {
                 _showGameDialog(); 
              }),
            ],
          ),
        ),
      ],
    );
  }

  void _showGameDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("选择游戏模式"),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _squareButton("跑酷", "assets/images/rungame_btn.png", () {
              debugPrint("跳转跑酷场景");
              Navigator.pop(context);
            }),
            const SizedBox(width: 10),
            _squareButton("探索", "assets/images/travelgame_btn.png", () {
              debugPrint("跳转探索场景");
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  // 唯一的、正确的纯图片方形按钮模板
  Widget _squareButton(String label, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox( // 使用 SizedBox 固定大小
        width: 75, height: 75,
        child: Image.asset(
          imagePath, 
          fit: BoxFit.fill, // 关键点：让图片拉伸填满 SizedBox
          // 这里虽然去掉了 Text，但 label 可以作为语义化属性保留
          semanticLabel: label, 
          // 路径写错时的占位图
          errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.brown)),
        ),
      ),
    );
  }
}
